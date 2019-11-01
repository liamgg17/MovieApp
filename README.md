# MovieApp
Rappi Challenge


Para el desarrollo del proyecto se utilizó la arquitectura VIPER en donde por cada módulo contemplado se hace uso de las diferentes capas de la aplicación
El proyecto contempla dos módulos VIPER:

Movie: Vista principal con la lista de películas filtradas por categorías (Popular,Top Rated, Upcoming=
MovieDetail: Vista detalle de una película

## Movie:

+ __MovieInteractor:__ Clase encargada de comunicar MoviePresenter  con MovieRemoteDataManager. El interactor recibe del Presenter las solicitudes para obtener las películas de una sección determinada la cual a su vez comunica al Presenter la respuesta obtenida del RemoteDataManager. El interactor también se comunica con MoviEntity y SectionEntity.
+ __MovieProtocols:__ Clase que define los protocolos contenidos en el módulo Movie
+ __MoviePresenter:__ Clase encargada de comunicar la vista (MovieView) con el Interactor (MovieInteractor). También se comunica con MovieWireFrame para ir a la vista detalle. Aquí se establece la lógica del negocio como obtener la sección actual, determinar si se está realizando una búsqueda o si se está solicitando la siguiente página de la lista de películas
+ __MovieView:__ Clase que contiene la vista (ViewController) de la pantalla principal. A su vez como parte de la capa Vista el ViewController utiliza Movie.storyboard y CollectionMovieCell con su .xib correspondiente.
+ __MovieRemoteDatamanager:__ Encargada de realizar el request de películas al servidor., Utiliza NetworkManager  y Alamofire para gestionar las peticiones al servidor.
+ __MovieWireFrame:__ Contiene la lógica de navegación entre pantallas de la aplicación. Así mismo crear la instancia del ViewController. 
+ __MovieEntity:__ Contiene el módelo básico del objeto Movie. A su vez tiene parte de las responsabilidades de la capa Modelo.
+ __SectionEntity:__ Contiene el módelo básico del objeto Section.
 
## MovieDetail:

+ __MovieDetailInteractor:__ Clase encargada de comunicar MovieDetailPresenter  con MovieDetailRemoteDataManager. El interactor recibe del Presenter las solicitudes para obtener el detalle de una película seleccionada la cual a su vez comunica al Presenter la respuesta obtenida del RemoteDataManager. El interactor también se comunica con MoviEntity 
+ __MovieDetailProtocols:__ Clase que define los protocolos contenidos en el módulo MovieDetail
+ __MovieDetailPresenter: __Clase encargada de comunicar la vista (MovieDetailView) con el Interactor (MovieDetailInteractor). 
+ __MovieDetailView:__ Clase que contiene la vista detalle (ViewController) de una película. A su vez como parte de la capa Vista el ViewController utiliza MovieDetail.storyboard
+ __MovieDetailRemoteDatamanager:__ Encargada de realizar el request del detalle de una película al servidor, Utiliza NetworkManager  y Alamofire para gestionar las peticiones al servidor.
+ __MovieDetailWireFrame:__ Contiene la lógica de navegación entre pantallas de la aplicación. Así mismo crear la instancia del ViewController. 
+ __VideoEntity:__ Contiene el módelo básico del objeto Video. 
 
## Adicionales

+ __ApiSettings:__ Clase common para todo el proyecto que define la URLBase y key para la llamda a los endpoints
+ __NetworkManager:__ Clase encargada de gestionar errores de red y determinar si hay o no conexión a internet (Reachability)
+ __Extensions:__ Se utilizan varias extensiones que son comunes a todo el proyecto para añadir funcionalidad necesaria como: UIVewExtension, UIIMageViewExtension, UIColorExtension, DateExtension, DoubleExtension.
 
 
## ¿En qué consiste el principio de responsabilidad unica? ¿Cual es su propósito? 
 
El principio de responsabilidad única consiste en que cada módulo o clase debe encargarse de hacer solo una cosa específica y no intentar hacer  más de lo que debería. En este caso al utilizar la arquietectura VIPER, cada bloque corresponde a un objeto con tareas específicas, inputs y outputs. Básicamente se divide la lógica de aplicación en capas de funcionalidad más pequeñas, cada una de ellas con un  con una responsabilidad predefinida. 
 
## ¿Qué características tiene, según su opinión, un “buen” código o código limpio?

En mi opinión un buen código es principalmente el que es fácil de leer, como desarrolladores invertimos más tiempo leyendo código que escribiendo. Para lo cual  un buen código debe basarse en buenas prácticas, debe ser modular, contar con una arquitectura bien definida, no ser repetitivo. entre otras cosas.  Creo que al final realizar un buen código depende de mucha práctica, de lograr abstraer elementos similares y como dicen “No hay mejor código que el que no ha sido escrito aún”.  

