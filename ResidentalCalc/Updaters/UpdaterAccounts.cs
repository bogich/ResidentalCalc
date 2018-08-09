using System;
using ResidentalCalc.Infrastructure.HouseManagementService;

namespace ResidentalCalc.Updaters.UpdaterAccounts
{
    /// <summary>
    /// Класс для работы с лицевыми счетами
    /// </summary>
    class UpdaterAccounts
    {
        /// <summary>
        /// Вставка строки в перечень лицевых счетов
        /// </summary>
        /// <param name="_objectAddress">Элемент перечня адресных объектов</param>
        /// <param name="_exportAccount">Элемент перечня лицевых счетов в ГИС ЖКХ</param>
        /// <returns>Результат вставки</returns>
        public static string InsertAccount(ObjectAddress _objectAddress, exportAccountResultType _exportAccount)
        {
            string _result;
            try
            {
                Program.db.spInsertAccount(Guid.Parse(_objectAddress.GUID.ToString()),
                    _exportAccount.AccountNumber,
                    true,
                    int.Parse(_exportAccount.LivingPersonsNumber ?? "2"),
                    Guid.Parse(_exportAccount.AccountGUID));

                _result = "Account is synchronized";
            }
            catch(Exception e)
            {
                _result = e.Message;
            }

            return _result;
        }
    }
}
