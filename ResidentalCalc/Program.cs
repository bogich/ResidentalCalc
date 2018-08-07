using System;
using System.Net;
using System.Collections.Generic;
using System.Linq;
using System.Data.Linq;
using ResidentalCalc.Helpers.HelperHouseManagementService;
using ResidentalCalc.Helpers.HelperDeviceMeteringService;
using ResidentalCalc.Helpers.HelperBillService;
using ResidentalCalc.Helpers.HelperNsiService;
using _HouseManagementService = ResidentalCalc.Infrastructure.HouseManagementService;
using _DeviceMeteringService = ResidentalCalc.Infrastructure.DeviceMeteringService;
using _NsiService = ResidentalCalc.Infrastructure.NsiService;
using _BillsService = ResidentalCalc.Infrastructure.BillsService;

namespace ResidentalCalc
{
    class Program
    {
        //private const string _orgPPAGUID = "04b83d24-6daa-47f9-bb4f-ce9330c3094d"; //Prod 
        private const string _orgPPAGUID = "73075d22-be00-47c3-ad82-e95be27ac276"; // SIT01
        static string _ExportContractRootGUID;
        static void Main(string[] args)
        {
            ServicePointManager.ServerCertificateValidationCallback = delegate { return true; };

            HelperHouseManagementService helperHouseManagementService = new HelperHouseManagementService();
            HelperDeviceMeteringService helperDeviceMeteringService = new HelperDeviceMeteringService();
            HelperNsiService helperNsiService = new HelperNsiService();
            HelperBillService helperBillService = new HelperBillService();

            ResidentalCalcDataClassesDataContext db = new ResidentalCalcDataClassesDataContext();
            
            #region Синхронизируем справочник 51 Коммунальные услуги
            Table<RefNsiService51> refNsiService51 = db.GetTable<RefNsiService51>();

            var itemNsiReference51 = helperNsiService.GetNsiReference51(_orgPPAGUID).exportNsiItemResult;
            var nsiElement = itemNsiReference51.Item as _NsiService.NsiItemType;
            foreach(var itemNsiElement in nsiElement.NsiElement)
            {
                if(!(refNsiService51.Any(obj => obj.Code == itemNsiElement.Code
                && obj.GUID == Guid.Parse(itemNsiElement.GUID))))
                {
                    db.spInsertRefNsiService51(itemNsiElement.Code,
                        Guid.Parse(itemNsiElement.GUID),
                        itemNsiElement.IsActual,
                        ((_NsiService.NsiElementStringFieldType)itemNsiElement.NsiElementField[1]).Value);
                    Console.WriteLine("NsiService51 is synchronized");
                }
                else
                {
                    foreach(var itemRef in refNsiService51.Where(s => s.GUID == Guid.Parse(itemNsiElement.GUID)))
                    {
                        if(itemRef.IsActual != itemNsiElement.IsActual)
                        {
                            itemRef.IsActual = itemNsiElement.IsActual;
                            db.SubmitChanges();
                            Console.WriteLine("Item is correct");
                        }
                        else
                        {
                            Console.WriteLine("NsiService51 already exist");
                        }
                    }
                }
            }
            #endregion

            #region Синхронизируем договоры
            Table<SupplyResourceContract> supplyResourceContracts = db.GetTable<SupplyResourceContract>();

            string typeRes = null;
            do
            {
                foreach (var tmpSupplyResourceContract in helperHouseManagementService.GetSupplyResourceContractData(_orgPPAGUID, _ExportContractRootGUID).exportSupplyResourceContractResult.Items)
                {
                    typeRes = tmpSupplyResourceContract.ToString();
                    if (tmpSupplyResourceContract.GetType() == typeof(_HouseManagementService.exportSupplyResourceContractResultType))
                    {
                        var tmpExportSupplyResourceContract = tmpSupplyResourceContract as _HouseManagementService.exportSupplyResourceContractResultType;
                        if (tmpExportSupplyResourceContract.VersionStatus == _HouseManagementService.exportSupplyResourceContractResultTypeVersionStatus.Posted
                            && tmpExportSupplyResourceContract.Item1.GetType() == typeof(_HouseManagementService.ExportSupplyResourceContractTypeApartmentBuildingOwner))
                        {
                            if(!(supplyResourceContracts.Any(obj => obj.GIS_ContractRootGUID == Guid.Parse(tmpExportSupplyResourceContract.ContractRootGUID))))
                            {
                                db.spInsertSupplyResourceContract(((_HouseManagementService.ExportSupplyResourceContractTypeIsContract)tmpExportSupplyResourceContract.Item).ContractNumber,
                                    ((_HouseManagementService.ExportSupplyResourceContractTypeIsContract)tmpExportSupplyResourceContract.Item).SigningDate,
                                    DateTime.Parse("2079-01-01"),
                                    true,
                                    Guid.Parse(tmpExportSupplyResourceContract.ContractRootGUID));
                                Console.WriteLine("Contract is synchronized");
                            }
                            else
                            {
                                Console.WriteLine("Contract already exist");
                            }
                        }
                    }
                    else
                    {
                        _ExportContractRootGUID = tmpSupplyResourceContract.ToString();
                    }
                }
            }
            while (typeRes != "True");
            #endregion

            #region Синхронизация предметов договора
            Table<ContractSubject> contractSubject = db.GetTable<ContractSubject>();

            foreach (var item in supplyResourceContracts.Where(s => s.GIS_ContractRootGUID != null))
            {
                foreach(var itemContract in helperHouseManagementService.GetSupplyResourceContractDataByContractRootGUID(_orgPPAGUID, item.GIS_ContractRootGUID.ToString()).exportSupplyResourceContractResult.Items)
                {
                    if (itemContract.GetType() == typeof(_HouseManagementService.exportSupplyResourceContractResultType))
                    {
                        var tmpContract = itemContract as _HouseManagementService.exportSupplyResourceContractResultType;
                        var itemContractSubject = tmpContract.ContractSubject as _HouseManagementService.ExportSupplyResourceContractTypeContractSubject[];
                        foreach (var tmpContractSubject in itemContractSubject)
                        {
                            if(!(contractSubject.Any(obj => obj.SupplyResourceContractGUID == item.GUID
                            && obj.ServiceGUID == Guid.Parse("2270143B-A8D6-44DE-882C-0E4EC953A011")
                            || obj.ServiceGUID == Guid.Parse("09C92E62-A67C-46BA-9C7C-46FC6EC72A45"))))
                            {
                                db.spInsertContractSubject(tmpContractSubject.StartSupplyDate,
                                tmpContractSubject.EndSupplyDate,
                                Guid.Parse("2270143B-A8D6-44DE-882C-0E4EC953A011"),
                                item.GUID);
                                Console.WriteLine("Contract subject is synchronized");
                            }
                            else
                            {
                                Console.WriteLine("Contract subject already exist");
                            }
                        }
                    }
                }
            }
            #endregion

            #region Синхронизируем адресные объекты
            Table<ObjectAddress> objectAddresses = db.GetTable<ObjectAddress>();

            foreach (var item in supplyResourceContracts.Where(s => s.GIS_ContractRootGUID != null))
            {
                foreach(var itemObjectAddress in helperHouseManagementService.GetSupplyResourceContractObjectAddressData(_orgPPAGUID, item.GIS_ContractRootGUID.ToString()).exportSupplyResourceContractObjectAddressResult.Items)
                {
                    if(itemObjectAddress.GetType() == typeof(_HouseManagementService.exportSupplyResourceContractObjectAddressResultType))
                    {
                        var tmpItemObjectAddress = itemObjectAddress as _HouseManagementService.exportSupplyResourceContractObjectAddressResultType;
                        if(!(objectAddresses.Any(obj => obj.GIS_ObjectGUID == Guid.Parse(tmpItemObjectAddress.ObjectGUID)
                        && obj.SupplyResourceContractGUID == item.GUID)))
                        {
                            db.spInsertObjectAddress(Guid.Parse(item.GUID.ToString()),
                                Guid.Parse(tmpItemObjectAddress.FIASHouseGuid.ToString()),
                                tmpItemObjectAddress.ApartmentNumber,
                                tmpItemObjectAddress.RoomNumber,
                                Guid.Parse(tmpItemObjectAddress.ObjectGUID));
                            Console.WriteLine("Object address is synchronized");
                        }
                        else
                        {
                            Console.WriteLine("Object address already exist");
                        }
                    }
                }
            }
            #endregion

            #region Синхронизируем лицевые счета
            Table<Accounts> accounts = db.GetTable<Accounts>();

            foreach (var item in objectAddresses.Where(s => s.GIS_ObjectGUID != null))
            {
                foreach(var itemAccount in helperHouseManagementService.GetAccountDataByFiasGuid(_orgPPAGUID, item.FIASHouseGUID.ToString()).exportAccountResult.Items)
                {
                    if(itemAccount.GetType() == typeof(_HouseManagementService.exportAccountResultType))
                    {
                        var tmpAccount = itemAccount as _HouseManagementService.exportAccountResultType;
                        if(!(accounts.Any(obj => obj.GIS_AccountGUID == Guid.Parse(tmpAccount.AccountGUID)
                        && obj.ObjectAddressGUID == item.GUID)))
                        {
                            db.spInsertAccount(Guid.Parse(item.GUID.ToString()),
                                tmpAccount.AccountNumber,
                                true,
                                int.Parse(tmpAccount.LivingPersonsNumber ?? "2"),
                                Guid.Parse(tmpAccount.AccountGUID));
                            Console.WriteLine("Account is synchronized");
                        }
                        else
                        {
                            Console.WriteLine("Account already exist");
                        }
                    }
                }
            }
            #endregion

            #region Синхронизируем приборы учета
            Table<MeteringDevice> meteringDevice = db.GetTable<MeteringDevice>();

            foreach (var item in objectAddresses.Where(s => s.GIS_ObjectGUID != null))
            {
                foreach(var itemMeteringDevice in helperHouseManagementService.GetMeteringDeviceData(_orgPPAGUID, item.FIASHouseGUID.ToString()).exportMeteringDeviceDataResult.Items)
                {
                    if(itemMeteringDevice.GetType() == typeof(_HouseManagementService.exportMeteringDeviceDataResultType))
                    {
                        var tmpMeterongDevice = itemMeteringDevice as _HouseManagementService.exportMeteringDeviceDataResultType;
                        if(!(meteringDevice.Any(obj => obj.GIS_MeteringDeviceGUID == Guid.Parse(tmpMeterongDevice.MeteringDeviceRootGUID)
                        && obj.ObjectAddressGUID == item.GUID)))
                        {
                            db.spInsertMeteringDevice(Guid.Parse(item.GUID.ToString()),
                                tmpMeterongDevice.BasicChatacteristicts.MeteringDeviceModel,
                                tmpMeterongDevice.BasicChatacteristicts.MeteringDeviceStamp,
                                tmpMeterongDevice.BasicChatacteristicts.MeteringDeviceNumber,
                                6,
                                tmpMeterongDevice.BasicChatacteristicts.InstallationDate,
                                tmpMeterongDevice.BasicChatacteristicts.FirstVerificationDate,
                                Guid.Parse(tmpMeterongDevice.MeteringDeviceRootGUID));
                            Console.WriteLine("Metering device is synchronized");
                        }
                        else
                        {
                            Console.WriteLine("Metering device already exist");
                        }
                    }
                }
            }
            #endregion

            #region Синхронизируем показания приборов учета
            Table<MeteringDeviceHistory> meteringDeviceHistory = db.GetTable<MeteringDeviceHistory>();

            foreach (var item in meteringDevice.Where(s => s.GIS_MeteringDeviceGUID != null))
            {
                foreach(var itemMeteringDeviceHistory in helperDeviceMeteringService.GetMeteringDeviceHistory(_orgPPAGUID, item.ObjectAddress.FIASHouseGUID.ToString(), item.GIS_MeteringDeviceGUID.ToString()).exportMeteringDeviceHistoryResult.Items)
                {
                    if(itemMeteringDeviceHistory.GetType() == typeof(_DeviceMeteringService.exportMeteringDeviceHistoryResultType))
                    {
                        var tmpMeteringDeviceHistory = itemMeteringDeviceHistory as _DeviceMeteringService.exportMeteringDeviceHistoryResultType;
                        var tmpMeteringDeviceHistoryDetail = tmpMeteringDeviceHistory.Item as _DeviceMeteringService.exportMeteringDeviceHistoryResultTypeOneRateDeviceValue;
                        foreach(var itemCurrentValue in tmpMeteringDeviceHistoryDetail.Values.CurrentValue)
                        {
                            var tmpCurrentValue = itemCurrentValue as _DeviceMeteringService.OneRateCurrentMeteringValueExportType;
                            if (!(meteringDeviceHistory.Any(obj => obj.MeteringDeviceDate == tmpCurrentValue.DateValue
                                && obj.MeteringDeviceValue == Convert.ToDecimal(tmpCurrentValue.MeteringValue))))
                            {
                                db.spInsertMeteringDeviceHistory(item.GUID,
                                    Convert.ToDecimal(tmpCurrentValue.MeteringValue),
                                    tmpCurrentValue.DateValue);
                                Console.WriteLine("Metering device value is synchronized");
                            }
                            else
                            {
                                Console.WriteLine("Metering device value already exist");
                            }
                        }
                    }
                }
            }
            #endregion

            #region Синхронизация плательщиков
            Table<PayerInfo> payerInfo = db.GetTable<PayerInfo>();

            foreach (var item in accounts.Where(s => s.GIS_AccountGUID != null))
            {
                foreach(var itemAccount in helperHouseManagementService.GetAccountDataByAccontGuid(_orgPPAGUID, item.GIS_AccountGUID.ToString()).exportAccountResult.Items)
                {
                    if(itemAccount.GetType() == typeof(_HouseManagementService.exportAccountResultType))
                    {
                        var tmpAccount = itemAccount as _HouseManagementService.exportAccountResultType;
                        if(!(payerInfo.Any(obj => obj.AccountGUID == item.GUID
                        && obj.Name == ((_HouseManagementService.AccountIndExportType)tmpAccount.PayerInfo.Item).FirstName
                        && obj.Surname == ((_HouseManagementService.AccountIndExportType)tmpAccount.PayerInfo.Item).Surname
                        && obj.GrandName == ((_HouseManagementService.AccountIndExportType)tmpAccount.PayerInfo.Item).Patronymic)))
                        {
                            var tmpAccountDetail = tmpAccount.PayerInfo as _HouseManagementService.AccountExportTypePayerInfo;
                            var tmp = tmpAccountDetail.Item as _HouseManagementService.AccountIndExportType;
                            db.spInsertPayerInfo(item.GUID,
                                ((_HouseManagementService.AccountIndExportType)tmpAccount.PayerInfo.Item).Surname,
                                ((_HouseManagementService.AccountIndExportType)tmpAccount.PayerInfo.Item).FirstName,
                                ((_HouseManagementService.AccountIndExportType)tmpAccount.PayerInfo.Item).Patronymic ?? null,
                                "11111111111",
                                ((_HouseManagementService.AccountIndExportTypeID)tmp.Item).Series ?? null,
                                ((_HouseManagementService.AccountIndExportTypeID)tmp.Item).Number ?? null,
                                ((_HouseManagementService.AccountIndExportTypeID)tmp.Item).IssueDate);
                            Console.WriteLine("Payer info is synchronized");
                        }
                        else
                        {
                            Console.WriteLine("Payer info already exist");
                        }
                    }
                }
            }
            #endregion

            Console.Read();

            #region Создание расчетов
            Table<Calculation> calculation = db.GetTable<Calculation>();

            foreach (var itemAccount in accounts)
            {
                try
                {
                    if(!(calculation.Any(obj => obj.AccountGUID == itemAccount.GUID
                    && obj.CalculationMonth == DateTime.Now.Month
                    && obj.CalculationYear == DateTime.Now.Year)))
                    {
                        db.spCreateCalculation(itemAccount.GUID, DateTime.Now.Month, DateTime.Now.Year);
                        Console.WriteLine("Calculation success");
                    }
                    else
                    {
                        Console.WriteLine("Calculation already exist");
                    }
                }
                catch(Exception e)
                {
                    Console.WriteLine(e);
                }
            }
            #endregion

            #region Синхронизация квитанций
            Table<vwChargeInfo> ChargeInfo = db.GetTable<vwChargeInfo>();
            List<_BillsService.PaymentDocumentTypeChargeInfo> paymentDocumentTypeChargeInfos = new List<_BillsService.PaymentDocumentTypeChargeInfo>();
            _BillsService.PDServiceChargeTypeMunicipalServiceVolumeDeterminingMethod _determiningMethod;

            foreach (var itemCalculation in calculation.Where(s => s.GIS_PaymentDocumentNumber == null))
            {
                foreach(var itemChargeInfo in ChargeInfo.Where(s => s.CalculationGUID == itemCalculation.GUID))
                {
                    if (itemChargeInfo.VolumeDeterminingMethodChar == "N")
                    {
                        _determiningMethod = _BillsService.PDServiceChargeTypeMunicipalServiceVolumeDeterminingMethod.N;
                    }
                    else
                    {
                        if (itemChargeInfo.VolumeDeterminingMethodChar == "O")
                        {
                            _determiningMethod = _BillsService.PDServiceChargeTypeMunicipalServiceVolumeDeterminingMethod.O;
                        }
                        else
                        {
                            _determiningMethod = _BillsService.PDServiceChargeTypeMunicipalServiceVolumeDeterminingMethod.M;
                        }
                    }

                    paymentDocumentTypeChargeInfos.Add(new _BillsService.PaymentDocumentTypeChargeInfo
                    {
                        Item = new _BillsService.PDServiceChargeTypeMunicipalService
                        {
                            AccountingPeriodTotal = (decimal)itemChargeInfo.CalculationResult, //Всего начислено за расчетный период
                            TotalPayable = (decimal)itemChargeInfo.CalculationResult, //Итого к оплате за расчетный период
                            Rate = contractSubject.Where(s => s.GUID == itemChargeInfo.ContractSubjectGUID).First().RefServices.RefTariff.TariffValue, //Тариф
                            ServiceType = new _BillsService.nsiRef
                            {
                                Code = contractSubject.First(s => s.GUID == itemChargeInfo.ContractSubjectGUID).RefServices.RefNsiService51.Code,
                                GUID = contractSubject.First(s => s.GUID == itemChargeInfo.ContractSubjectGUID).RefServices.RefNsiService51.GUID.ToString()
                            },
                            Consumption = new _BillsService.PDServiceChargeTypeMunicipalServiceVolume[]
                            {
                                new _BillsService.PDServiceChargeTypeMunicipalServiceVolume
                                {

                                    typeSpecified = true,
                                    type = _BillsService.PDServiceChargeTypeMunicipalServiceVolumeType.I, //(I)ndividualConsumption - индивидульное потребление (O)verallNeeds - общедомовые нужды
                                    determiningMethodSpecified = true,
                                    determiningMethod = _determiningMethod, //(N)orm - Норматив (M)etering device - Прибор учета (O)ther - Иное
                                    Value = (decimal)itemChargeInfo.Volume
                                }
                            },
                            ServiceInformation = new _BillsService.ServiceInformation
                            {
                                individualConsumptionNormSpecified = true,
                                individualConsumptionNorm = contractSubject.First().RefServices.RefStandard.StandardValue //Норматив потребления в жилых помещениях
                            }
                        }
                    });
                }

                try
                {
                    var test = helperBillService.SetPaymentDocumentData(_orgPPAGUID, itemCalculation.Accounts.GIS_AccountGUID.ToString(), paymentDocumentTypeChargeInfos).ImportResult.Items;
                    foreach(var itemTest in test)
                    {
                        if (itemTest.GetType() == typeof(_BillsService.CommonResultType))
                        {
                            var resTest = itemTest as _BillsService.CommonResultType;
                            foreach(var itemResTest in resTest.Items)
                            {
                                if (itemResTest.GetType() == typeof(_BillsService.CommonResultTypeError))
                                {
                                    var resError = itemResTest as _BillsService.CommonResultTypeError;
                                    Console.WriteLine("{0}: {1}", resError.ErrorCode, resError.Description);
                                }
                                else
                                {
                                    itemCalculation.GIS_PaymentDocumentNumber = itemResTest.ToString();
                                    db.SubmitChanges();
                                    Console.WriteLine(itemResTest);
                                }
                            }
                        }
                    }
                    Console.WriteLine("Payment document is synchronized");
                }
                catch (Exception e)
                {
                    Console.WriteLine(e);
                }
                finally
                {
                    paymentDocumentTypeChargeInfos.Clear();
                }
            }
            #endregion

            Console.Read();
        }
    }
}
