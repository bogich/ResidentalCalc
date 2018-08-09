using System;
using ResidentalCalc.Infrastructure.DeviceMeteringService;

namespace ResidentalCalc.Updaters.UpdaterMeteringDeviceHistory
{
    /// <summary>
    /// Класс для работы с историей показаний прибора учета
    /// </summary>
    class UpdaterMeteringDeviceHistory
    {
        /// <summary>
        /// Вставка показания прибора учета
        /// </summary>
        /// <param name="_meteringDevice">Элемент перечня приборов учета</param>
        /// <param name="_oneRateCurrentMeteringValue">Элемент списка текущий показаний прибора учета в ГИС ЖКХ</param>
        /// <returns>Результат вставки</returns>
        public static string InsertMeteringDeviceHistory(MeteringDevice _meteringDevice, OneRateCurrentMeteringValueExportType _oneRateCurrentMeteringValue)
        {
            string _result;
            try
            {
                Program.db.spInsertMeteringDeviceHistory(_meteringDevice.GUID,
                    Convert.ToDecimal(_oneRateCurrentMeteringValue.MeteringValue),
                    _oneRateCurrentMeteringValue.DateValue);

                _result = "Metering device value is synchronized";
            }
            catch(Exception e)
            {
                _result = e.Message;
            }

            return _result;
        }
    }
}
