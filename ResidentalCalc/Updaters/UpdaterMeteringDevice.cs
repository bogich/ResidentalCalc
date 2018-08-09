using System;
using ResidentalCalc.Infrastructure.HouseManagementService;

namespace ResidentalCalc.Updaters.UpdaterMeteringDevice
{
    /// <summary>
    /// Класс для работы с приборами учета
    /// </summary>
    class UpdaterMeteringDevice
    {
        /// <summary>
        /// Обновление строки перечня приборов учета
        /// </summary>
        /// <param name="_meteringDevice">Элемент перечня приборов учета</param>
        /// <param name="_exportMeteringDevice">Прибор учета в ГИС ЖКХ</param>
        /// <returns>Результат обновления</returns>
        public static string UpdateMeteringDevice(MeteringDevice _meteringDevice, exportMeteringDeviceDataResultType _exportMeteringDevice)
        {
            string _result;
            try
            {
                _meteringDevice.MeteringDeviceModel = _exportMeteringDevice.BasicChatacteristicts.MeteringDeviceModel;
                _meteringDevice.MeteringDeviceStamp = _exportMeteringDevice.BasicChatacteristicts.MeteringDeviceStamp;
                _meteringDevice.MeteringDeviceNumber = _exportMeteringDevice.BasicChatacteristicts.MeteringDeviceNumber;
                _meteringDevice.VerificationInterval = 6;
                _meteringDevice.InstallationDate = _exportMeteringDevice.BasicChatacteristicts.InstallationDate;
                _meteringDevice.VerificationDate = _exportMeteringDevice.BasicChatacteristicts.FirstVerificationDate;
                _meteringDevice.GIS_VersionNumber = int.Parse(_exportMeteringDevice.VersionNumber);
                Program.db.SubmitChanges();

                _result = "Metering device item is correct";
            }
            catch(Exception e)
            {
                _result = e.Message;
            }

            return _result;
        }

        /// <summary>
        /// Вставка строки в перечень приборов учета
        /// </summary>
        /// <param name="_exportMeteringDevice">Прибор учета в ГИС ЖКХ</param>
        /// <param name="_objectAddress">Адресный объект, к которому относится прибор учета</param>
        /// <returns>Результат вставки</returns>
        public static string InsertMeteringDevice(exportMeteringDeviceDataResultType _exportMeteringDevice, ObjectAddress _objectAddress)
        {
            string _result;

            try
            {
                Program.db.spInsertMeteringDevice(Guid.Parse(_objectAddress.GUID.ToString()),
                    _exportMeteringDevice.BasicChatacteristicts.MeteringDeviceModel,
                    _exportMeteringDevice.BasicChatacteristicts.MeteringDeviceStamp,
                    _exportMeteringDevice.BasicChatacteristicts.MeteringDeviceNumber,
                    6,
                    _exportMeteringDevice.BasicChatacteristicts.InstallationDate,
                    _exportMeteringDevice.BasicChatacteristicts.FirstVerificationDate,
                    Guid.Parse(_exportMeteringDevice.MeteringDeviceRootGUID),
                    int.Parse(_exportMeteringDevice.VersionNumber));

                _result = "Metering device element is synchronized";
            }
            catch(Exception e)
            {
                _result = e.Message;
            }

            return _result;
        }
    }
}
