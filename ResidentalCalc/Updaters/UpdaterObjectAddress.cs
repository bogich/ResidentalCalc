using System;
using ResidentalCalc.Infrastructure.HouseManagementService;

namespace ResidentalCalc.Updaters.UpdaterObjectAddress
{
    class UpdaterObjectAddress
    {
        public static string InsertObjectAddress(SupplyResourceContract _supplyResourceContract, exportSupplyResourceContractObjectAddressResultType _exportObjectAddress)
        {
            string _result;
            try
            {
                Program.db.spInsertObjectAddress(Guid.Parse(_supplyResourceContract.GUID.ToString()),
                    Guid.Parse(_exportObjectAddress.FIASHouseGuid.ToString()),
                    _exportObjectAddress.ApartmentNumber,
                    _exportObjectAddress.RoomNumber,
                    Guid.Parse(_exportObjectAddress.ObjectGUID));

                _result = "Object address is synchronized";
            }
            catch(Exception e)
            {
                _result = e.Message;
            }

            return _result;
        }
    }
}
