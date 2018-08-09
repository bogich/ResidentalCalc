using System;
using ResidentalCalc.Infrastructure.NsiService;

namespace ResidentalCalc.Updaters.UpdaterRefNsiService51
{
    /// <summary>
    /// Класс для работы со справочником 51 Коммунальные услуги
    /// </summary>
    class UpdaterRefNsiService51
    {
        /// <summary>
        /// Обновление строки справочника 51 Коммунальные услуги
        /// </summary>
        /// <param name="_refNsiService51">Элемент справочника в БД</param>
        /// <param name="_nsiElementType">Элемент справочника в ГИС ЖКХ</param>
        /// <returns>Результат обновления</returns>
        public static string UpdateElementNsiReference51(RefNsiService51 _refNsiService51, NsiElementType _nsiElementType)
        {
            string _result;

            try
            {
                _refNsiService51.Code = _nsiElementType.Code;
                _refNsiService51.GUID = Guid.Parse(_nsiElementType.GUID);
                _refNsiService51.IsActual = _nsiElementType.IsActual;
                _refNsiService51.Value = ((NsiElementStringFieldType)_nsiElementType.NsiElementField[1]).Value;
                _refNsiService51.GIS_Modified = _nsiElementType.Items[0].Date;
                Program.db.SubmitChanges();

                _result = "NsiService51 item is correct";
            }
            catch(Exception e)
            {
                _result = e.Message;
            }

            return _result;
        }

        /// <summary>
        /// Вставка строки справочника 51 Коммунальные услуги
        /// </summary>
        /// <param name="_nsiElementType">Элемент справочника в ГИС ЖКХ</param>
        /// <returns>Результат вставки</returns>
        public static string InsertElementNsiReference51(NsiElementType _nsiElementType)
        {
            string _result;

            try
            {
                Program.db.spInsertRefNsiService51(_nsiElementType.Code,
                    Guid.Parse(_nsiElementType.GUID),
                    _nsiElementType.IsActual,
                    ((NsiElementStringFieldType)_nsiElementType.NsiElementField[1]).Value,
                    _nsiElementType.Items[0].Date);

                _result = "NsiService51 element is synchronized";
            }
            catch (Exception e)
            {
                _result = e.Message;
            }

            return _result;
        }
    }
}
