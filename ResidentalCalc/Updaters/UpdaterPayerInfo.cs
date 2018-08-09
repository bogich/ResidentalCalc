using System;
using ResidentalCalc.Infrastructure.HouseManagementService;

namespace ResidentalCalc.Updaters.UpdaterPayerInfo
{
    /// <summary>
    /// Класс для работы с информацией о плательщике
    /// </summary>
    class UpdaterPayerInfo
    {
        /// <summary>
        /// Вставка строки в перечень плательщиков
        /// </summary>
        /// <param name="_accounts">Элемент перечня лицевых счетов</param>
        /// <param name="exportAccount">Элемент списка плательщиков в ГИС ЖКХ</param>
        /// <returns>Результат вставки</returns>
        public static string InsertPayerInfo(Accounts _accounts, exportAccountResultType exportAccount)
        {
            string _result;
            try
            {
                var tmpAccountDetail = exportAccount.PayerInfo as AccountExportTypePayerInfo;
                var tmpAccountIndDetail = tmpAccountDetail.Item as AccountIndExportType;
                Program.db.spInsertPayerInfo(_accounts.GUID,
                    ((AccountIndExportType)exportAccount.PayerInfo.Item).Surname,
                    ((AccountIndExportType)exportAccount.PayerInfo.Item).FirstName,
                    ((AccountIndExportType)exportAccount.PayerInfo.Item).Patronymic ?? null,
                    "11111111111",
                    ((AccountIndExportTypeID)tmpAccountIndDetail.Item).Series ?? null,
                    ((AccountIndExportTypeID)tmpAccountIndDetail.Item).Number ?? null,
                    ((AccountIndExportTypeID)tmpAccountIndDetail.Item).IssueDate);

                _result = "Payer info is synchronized";
            }
            catch(Exception e)
            {
                _result = e.Message;
            }

            return _result;
        }
    }
}
