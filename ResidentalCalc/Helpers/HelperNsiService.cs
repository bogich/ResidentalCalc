using System;
using ResidentalCalc.Infrastructure.NsiService;
using System.Configuration;
using System.Threading;

namespace ResidentalCalc.Helpers.HelperNsiService
{
    /// <summary>
    /// 2.2.3 Сервис частной НСИ
    /// </summary>
    class HelperNsiService
    {
        /// <summary>
        /// Экспорт данных справочника 1 "Дополнительные услуги"
        /// </summary>
        /// <param name="_orgPPAGUID">
        /// Идентификатор зарегистрированной организации
        /// </param>
        /// <returns>
        /// Данные справочника 1 "Дополнительные услуги"
        /// </returns>
        public exportDataProviderNsiItemResponse GetNsiReference1(string _orgPPAGUID)
        {
            var srvNsiService = new NsiPortsTypeClient();
            srvNsiService.ClientCredentials.UserName.UserName = ConfigurationManager.AppSettings["_login"];
            srvNsiService.ClientCredentials.UserName.Password = ConfigurationManager.AppSettings["_pass"];

            var reqNsiServiceExpRef1 = new exportDataProviderNsiItemRequest1
            {
                RequestHeader = new RequestHeader
                {
                    Date = DateTime.Now,
                    MessageGUID = Guid.NewGuid().ToString(),
                    ItemElementName = ItemChoiceType1.orgPPAGUID,
                    Item = _orgPPAGUID
                },
                exportDataProviderNsiItemRequest = new exportDataProviderNsiItemRequest
                {
                    version = "10.0.1.2",
                    RegistryNumber = exportDataProviderNsiItemRequestRegistryNumber.Item1
                }
            };

            var resNsiServiceExpRef1 = srvNsiService.exportDataProviderNsiItem(reqNsiServiceExpRef1);

            return resNsiServiceExpRef1;
        }

        /// <summary>
        /// Экспорт данных справочника 51 "Коммунальные услуги"
        /// </summary>
        /// <param name="_orgPPAGUID">
        /// Идентификатор зарегистрированной организации
        /// </param>
        /// <returns>
        /// Данные справочника 51 "Коммунальные услуги"
        /// </returns>
        public exportDataProviderNsiItemResponse GetNsiReference51(string _orgPPAGUID)
        {
            var srvNsiService = new NsiPortsTypeClient();
            srvNsiService.ClientCredentials.UserName.UserName = ConfigurationManager.AppSettings["_login"];
            srvNsiService.ClientCredentials.UserName.Password = ConfigurationManager.AppSettings["_pass"];

            var reqNsiServiceExpRef51 = new exportDataProviderNsiItemRequest1
            {
                RequestHeader = new RequestHeader
                {
                    Date = DateTime.Now,
                    MessageGUID = Guid.NewGuid().ToString(),
                    ItemElementName = ItemChoiceType1.orgPPAGUID,
                    Item = _orgPPAGUID
                },
                exportDataProviderNsiItemRequest = new exportDataProviderNsiItemRequest
                {
                    version = "10.0.1.2",
                    RegistryNumber = exportDataProviderNsiItemRequestRegistryNumber.Item51
                }
            };

            exportDataProviderNsiItemResponse resNsiServiceExpRef51 = null;
            do
            {
                try
                {
                    resNsiServiceExpRef51 = srvNsiService.exportDataProviderNsiItem(reqNsiServiceExpRef51);
                }
                catch (Exception e)
                {
                    Console.ForegroundColor = ConsoleColor.Red;
                    Console.WriteLine(e.Message);
                    Console.ResetColor();
                    Thread.Sleep(1000);
                }
            }
            while (resNsiServiceExpRef51 is null);

            return resNsiServiceExpRef51;
        }

        /// <summary>
        /// Экспорт данных справочника 59 "Работы и услуги организации"
        /// </summary>
        /// <param name="_orgPPAGUID">
        /// Идентификатор зарегистрированной организации
        /// </param>
        /// <returns>
        /// Данные справочника 59 "Работы и услуги организации"
        /// </returns>
        public exportDataProviderNsiItemResponse GetNsiReference59(string _orgPPAGUID)
        {
            var srvNsiService = new NsiPortsTypeClient();
            srvNsiService.ClientCredentials.UserName.UserName = ConfigurationManager.AppSettings["_login"];
            srvNsiService.ClientCredentials.UserName.Password = ConfigurationManager.AppSettings["_pass"];

            var reqNsiServiceExpRef59 = new exportDataProviderNsiItemRequest1
            {
                RequestHeader = new RequestHeader
                {
                    Date = DateTime.Now,
                    MessageGUID = Guid.NewGuid().ToString(),
                    ItemElementName = ItemChoiceType1.orgPPAGUID,
                    Item = _orgPPAGUID
                },
                exportDataProviderNsiItemRequest = new exportDataProviderNsiItemRequest
                {
                    version = "10.0.1.2",
                    RegistryNumber = exportDataProviderNsiItemRequestRegistryNumber.Item59
                }
            };

            var resNsiServiceExpRef59 = srvNsiService.exportDataProviderNsiItem(reqNsiServiceExpRef59);

            return resNsiServiceExpRef59;
        }

        /// <summary>
        /// Экспорт данных справочника 219 "Вид работ капитального ремонта"
        /// </summary>
        /// <param name="_orgPPAGUID">
        /// Идентификатор зарегистрированной организации
        /// </param>
        /// <returns>
        /// Данные справочника 219 "Вид работ капитального ремонта"
        /// </returns>
        public exportDataProviderNsiItemResponse GetNsiReference219(string _orgPPAGUID)
        {
            var srvNsiService = new NsiPortsTypeClient();
            srvNsiService.ClientCredentials.UserName.UserName = ConfigurationManager.AppSettings["_login"];
            srvNsiService.ClientCredentials.UserName.Password = ConfigurationManager.AppSettings["_pass"];

            var reqNsiServiceExpRef219 = new exportDataProviderNsiItemRequest1
            {
                RequestHeader = new RequestHeader
                {
                    Date = DateTime.Now,
                    MessageGUID = Guid.NewGuid().ToString(),
                    ItemElementName = ItemChoiceType1.orgPPAGUID,
                    Item = _orgPPAGUID
                },
                exportDataProviderNsiItemRequest = new exportDataProviderNsiItemRequest
                {
                    version = "10.0.1.2",
                    RegistryNumber = exportDataProviderNsiItemRequestRegistryNumber.Item219
                }
            };

            var resNsiServiceExpRef219 = srvNsiService.exportDataProviderNsiItem(reqNsiServiceExpRef219);

            return resNsiServiceExpRef219;
        }

        /// <summary>
        /// Экспорт данных справочника 272 "Система коммунальной инфраструктуры"
        /// </summary>
        /// <param name="_orgPPAGUID">
        /// Идентификатор зарегистрированной организации
        /// </param>
        /// <returns>
        /// Данные справочника 272 "Система коммунальной инфраструктуры"
        /// </returns>
        public exportDataProviderNsiItemResponse GetNsiReference272(string _orgPPAGUID)
        {
            var srvNsiService = new NsiPortsTypeClient();
            srvNsiService.ClientCredentials.UserName.UserName = ConfigurationManager.AppSettings["_login"];
            srvNsiService.ClientCredentials.UserName.Password = ConfigurationManager.AppSettings["_pass"];

            var reqNsiServiceExpRef272 = new exportDataProviderNsiItemRequest1
            {
                RequestHeader = new RequestHeader
                {
                    Date = DateTime.Now,
                    MessageGUID = Guid.NewGuid().ToString(),
                    ItemElementName = ItemChoiceType1.orgPPAGUID,
                    Item = _orgPPAGUID
                },
                exportDataProviderNsiItemRequest = new exportDataProviderNsiItemRequest
                {
                    version = "10.0.1.2",
                    RegistryNumber = exportDataProviderNsiItemRequestRegistryNumber.Item272
                }
            };

            var resNsiServiceExpRef272 = srvNsiService.exportDataProviderNsiItem(reqNsiServiceExpRef272);

            return resNsiServiceExpRef272;
        }

        /// <summary>
        /// Экспорт данных справочника 302 "Основание принятия решения о мерах социальной поддержки гражданина"
        /// </summary>
        /// <param name="_orgPPAGUID">
        /// Идентификатор зарегистрированной организации
        /// </param>
        /// <returns>
        /// Данные справочника 302 "Основание принятия решения о мерах социальной поддержки гражданина"
        /// </returns>
        public exportDataProviderNsiItemResponse GetNsiReference302(string _orgPPAGUID)
        {
            var srvNsiService = new NsiPortsTypeClient();
            srvNsiService.ClientCredentials.UserName.UserName = ConfigurationManager.AppSettings["_login"];
            srvNsiService.ClientCredentials.UserName.Password = ConfigurationManager.AppSettings["_pass"];

            var reqNsiServiceExpRef302 = new exportDataProviderNsiItemRequest1
            {
                RequestHeader = new RequestHeader
                {
                    Date = DateTime.Now,
                    MessageGUID = Guid.NewGuid().ToString(),
                    ItemElementName = ItemChoiceType1.orgPPAGUID,
                    Item = _orgPPAGUID
                },
                exportDataProviderNsiItemRequest = new exportDataProviderNsiItemRequest
                {
                    version = "10.0.1.2",
                    RegistryNumber = exportDataProviderNsiItemRequestRegistryNumber.Item302
                }
            };

            var resNsiServiceExpRef302 = srvNsiService.exportDataProviderNsiItem(reqNsiServiceExpRef302);

            return resNsiServiceExpRef302;
        }
    }
}
