using System;
using ResidentalCalc.Infrastructure.HouseManagementService;

namespace ResidentalCalc.Updaters.UpdaterSupplyResourceContract
{
    /// <summary>
    /// Класс для работы с договорами
    /// </summary>
    class UpdaterSupplyResourceContract
    {
        /// <summary>
        /// Обновление строки перечня договоров
        /// </summary>
        /// <param name="_exportSupplyResourceContract"></param>
        /// <returns>Результат обновления</returns>
        public static string UpdateSupplyResourceContract(SupplyResourceContract _supplyResourceContract, exportSupplyResourceContractResultType _exportSupplyResourceContract)
        {
            string _result;
            try
            {
                bool contractStatusVersion;
                if (_exportSupplyResourceContract.VersionStatus == exportSupplyResourceContractResultTypeVersionStatus.Posted)
                {
                    contractStatusVersion = true;
                }
                else
                {
                    contractStatusVersion = false;
                }

                _supplyResourceContract.ContractNumber = ((ExportSupplyResourceContractTypeIsContract)_exportSupplyResourceContract.Item).ContractNumber;
                _supplyResourceContract.SigningDateStart = ((ExportSupplyResourceContractTypeIsContract)_exportSupplyResourceContract.Item).SigningDate;
                _supplyResourceContract.SigningDateEnd = DateTime.Parse("0001-01-01");
                _supplyResourceContract.ContractState = contractStatusVersion;
                _supplyResourceContract.GIS_VersionNumber = int.Parse(_exportSupplyResourceContract.VersionNumber);
                Program.db.SubmitChanges();

                _result = "Supply resource contract item is correct";
            }
            catch(Exception e)
            {
                _result = e.Message;
            }

            return _result;
        }

        /// <summary>
        /// Вставка строки в перечень договоров
        /// </summary>
        /// <param name="_exportSupplyResourceContract"></param>
        /// <returns>Результат вставки</returns>
        public static string InsertSupplyResourceContract(exportSupplyResourceContractResultType _exportSupplyResourceContract)
        {
            string _result;
            try
            {
                bool contractStatusVersion;
                if(_exportSupplyResourceContract.VersionStatus == exportSupplyResourceContractResultTypeVersionStatus.Posted)
                {
                    contractStatusVersion = true;
                }
                else
                {
                    contractStatusVersion = false;
                }

                Program.db.spInsertSupplyResourceContract(((ExportSupplyResourceContractTypeIsContract)_exportSupplyResourceContract.Item).ContractNumber,
                    ((ExportSupplyResourceContractTypeIsContract)_exportSupplyResourceContract.Item).SigningDate,
                    DateTime.Parse("0001-01-01"),
                    contractStatusVersion,
                    Guid.Parse(_exportSupplyResourceContract.ContractRootGUID),
                    int.Parse(_exportSupplyResourceContract.VersionNumber));

                _result = "Supply resource contract is synchronized";
            }
            catch (Exception e)
            {
                _result = e.Message;
            }

            return _result;
        }
    }
}
