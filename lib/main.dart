import 'package:flutter/material.dart';

void main() {
  runApp(const TiendaRopaApp());
}

class TiendaRopaApp extends StatelessWidget {
  const TiendaRopaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tienda de Ropa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Map<String, String>> carrito = []; // ✅ Crear la lista del carrito

  late List<Widget> _pages; // ✅ Declaramos la lista sin inicializarla aún

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomePage(),
      const CategoriesPage(),
      ProductsPage(),
      // CartPage(carrito: carrito), // ✅ Ahora 'carrito' ya está inicializado
      const UserProfilePage(),
      const ContactPage(),
      const SupportPage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tienda de Ropa")),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                "Menú de Navegación",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            _buildDrawerItem(Icons.home, "Inicio", 0),
            _buildDrawerItem(Icons.category, "Categorías", 1),
            _buildDrawerItem(Icons.shopping_bag, "Productos", 2),
            _buildDrawerItem(Icons.person, "Perfil", 3),
            _buildDrawerItem(Icons.contact_mail, "Contacto", 4),
            _buildDrawerItem(Icons.help, "Soporte", 5),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        _onItemTapped(index);
        Navigator.pop(context);
      },
    );
  }
}

// Simulación de productos y noticias
final List<Map<String, String>> nuevasColecciones = [
  {
    "nombre": "Camisa de Moda",
    "precio": "\$25",
    "imagen": "assets/camisa.png",
    "descripcion": "Camisa elegante con diseño moderno.",
  },
  {
    "nombre": "Jeans Ajustados",
    "precio": "\$40",
    "imagen": "assets/jeans.png",
    "descripcion": "Jeans cómodos y con ajuste perfecto.",
  },
  {
    "nombre": "Vestido Elegante",
    "precio": "\$55",
    "imagen": "assets/vestido.png",
    "descripcion": "Vestido ideal para ocasiones especiales.",
  },
];

final List<Map<String, String>> promociones = [
  {
    "nombre": "Zapatos Deportivos",
    "precio": "\$30 (Antes \$50)",
    "imagen": "assets/zapatos.png",
    "descripcion": "Comodos y confortables varias tallas.",
  },
  {
    "nombre": "Chaqueta Casual",
    "precio": "\$45 (Antes \$70)",
    "imagen": "assets/chaqueta.png",
    "descripcion": "Ideal para el frio y super comoda.",
  },
];

final List<String> noticiasModa = [
  "🔹 Tendencia 2024: Los colores pastel están dominando las pasarelas.",
  "🔹 La moda sostenible está en auge, nuevas marcas eco-friendly emergen.",
  "🔹 Cómo combinar accesorios para un look moderno y elegante.",
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inicio")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 1, // Evita renderizar todo de golpe
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("🆕 Nuevas Colecciones"),
              _buildProductList(context, nuevasColecciones),
              _buildDivider(),

              _buildSectionTitle("🔥 Promociones"),
              _buildProductList(context, promociones),
              _buildDivider(),

              _buildSectionTitle("📰 Noticias Recientes"),
              _buildNewsList(),
            ],
          );
        },
      ),
    );
  }

  // Widget para mostrar títulos de sección
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  void _showProductModal(BuildContext context, Map<String, String> producto) {
    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // Permite que el modal ocupe más espacio en la pantalla
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Imagen del producto
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  producto["imagen"] ?? "assets/default.png",
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                  cacheWidth: 100, // Optimiza la memoria
                  cacheHeight: 100,
                ),
              ),
              const SizedBox(height: 20),

              // Nombre del producto
              Text(
                producto["nombre"]!,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              // Precio
              Text(
                producto["precio"]!,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Descripción
              Text(
                producto["descripcion"]!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 20),

              // Botón de cerrar
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  "Cerrar",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Widget para mostrar productos
  Widget _buildProductList(
    BuildContext context,
    List<Map<String, String>> productos,
  ) {
    return Column(
      children:
          productos.map((producto) {
            return Card(
              child: ListTile(
                leading: Image.asset(
                  producto["imagen"] ?? "assets/default.png",
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  cacheWidth: 100, // Optimiza la memoria
                  cacheHeight: 100,
                ),
                title: Text(producto["nombre"]!),
                subtitle: Text(
                  producto["precio"]!,
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const Icon(Icons.info_outline, color: Colors.blue),
                onTap: () {
                  _showProductModal(context, producto);
                },
              ),
            );
          }).toList(),
    );
  }

  // Widget para mostrar noticias
  Widget _buildNewsList() {
    return Column(
      children:
          noticiasModa.map((noticia) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(noticia, style: const TextStyle(fontSize: 16)),
              ),
            );
          }).toList(),
    );
  }

  // Línea divisoria entre secciones
  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Divider(thickness: 2, color: Colors.grey),
    );
  }
}

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  final List<Map<String, String>> categorias = const [
    {"nombre": "Pantalones", "imagen": "assets/cat_pantalones.png"},
    {"nombre": "Camisas", "imagen": "assets/cat_camisas.png"},
    {"nombre": "Vestidos", "imagen": "assets/cat_vestidos.png"},
    {"nombre": "Trajes de Baño", "imagen": "assets/cat_bano.png"},
    {"nombre": "Zapatos", "imagen": "assets/cat_zapatos.png"},
    {"nombre": "Accesorios", "imagen": "assets/cat_accesorios.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Categorías")),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.0, // Ajusta la forma de las tarjetas
        ),
        itemCount: categorias.length,
        itemBuilder: (context, index) {
          final categoria = categorias[index];
          return _buildCategoryCard(context, categoria);
        },
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    Map<String, String> categoria,
  ) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Seleccionaste ${categoria['nombre']}")),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Imagen de fondo opacada
            Opacity(
              opacity: 0.6, // Ajusta la opacidad para hacer la imagen más tenue
              child: Image.asset(categoria["imagen"]!, fit: BoxFit.cover),
            ),
            // Nombre de la categoría centrado
            Center(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  categoria["nombre"]!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ProductsPage - Lista de Productos
class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  ProductsPageState createState() => ProductsPageState();
}

class ProductsPageState extends State<ProductsPage> {
  final List<Map<String, String>> productos = [
    {
      "nombre": "Camisa de Moda",
      "precio": "25",
      "categoria": "Camisas",
      "imagen": "assets/camisa.png",
      "descripcion": "Camisa moderna con un diseño elegante y cómodo.",
    },
    {
      "nombre": "Jeans Ajustados",
      "precio": "40",
      "categoria": "Pantalones",
      "imagen": "assets/jeans.png",
      "descripcion": "Jeans ajustados perfectos para cualquier ocasión.",
    },
    {
      "nombre": "Vestido Elegante",
      "precio": "55",
      "categoria": "Vestidos",
      "imagen": "assets/vestido.png",
      "descripcion": "Vestido elegante y moderno para eventos especiales.",
    },
    {
      "nombre": "Zapatillas Deportivas",
      "precio": "50",
      "categoria": "Zapatos",
      "imagen": "assets/zapatos.png",
      "descripcion": "Zapatillas deportivas para mayor comodidad y estilo.",
    },
    {
      "nombre": "Chaqueta Casual",
      "precio": "70",
      "categoria": "Accesorios",
      "imagen": "assets/chaqueta.png",
      "descripcion": "Chaqueta casual perfecta para cualquier clima.",
    },

    // 🔹 Pantalones
    {
      "nombre": "Jeans Clásicos",
      "precio": "35",
      "categoria": "Pantalones",
      "imagen": "assets/pantalones1.png",
      "descripcion": "Jeans de corte clásico para cualquier ocasión.",
    },
    {
      "nombre": "Pantalón Cargo",
      "precio": "45",
      "categoria": "Pantalones",
      "imagen": "assets/pantalones2.png",
      "descripcion": "Pantalón cargo con múltiples bolsillos y estilo urbano.",
    },
    {
      "nombre": "Pantalón Deportivo",
      "precio": "30",
      "categoria": "Pantalones",
      "imagen": "assets/pantalones3.png",
      "descripcion": "Pantalón ideal para entrenamientos y deporte.",
    },

    // 🔹 Camisas
    {
      "nombre": "Camisa Formal Blanca",
      "precio": "30",
      "categoria": "Camisas",
      "imagen": "assets/camisa1.png",
      "descripcion": "Camisa blanca ideal para eventos formales.",
    },
    {
      "nombre": "Camisa Rayada Azul",
      "precio": "28",
      "categoria": "Camisas",
      "imagen": "assets/camisa2.png",
      "descripcion":
          "Camisa con diseño rayado azul, perfecta para el día a día.",
    },
    {
      "nombre": "Camisa Casual Negra",
      "precio": "32",
      "categoria": "Camisas",
      "imagen": "assets/camisa3.png",
      "descripcion": "Camisa negra casual, ideal para cualquier ocasión.",
    },

    // 🔹 Vestidos
    {
      "nombre": "Vestido de Fiesta",
      "precio": "70",
      "categoria": "Vestidos",
      "imagen": "assets/vestido1.png",
      "descripcion": "Vestido elegante de alta calidad para fiestas y eventos.",
    },
    {
      "nombre": "Vestido Casual",
      "precio": "55",
      "categoria": "Vestidos",
      "imagen": "assets/vestido2.png",
      "descripcion": "Vestido casual cómodo y perfecto para el día a día.",
    },
    {
      "nombre": "Vestido Floral",
      "precio": "65",
      "categoria": "Vestidos",
      "imagen": "assets/vestido3.png",
      "descripcion": "Vestido con estampado floral para una apariencia fresca.",
    },

    // 🔹 Trajes de Baño
    {
      "nombre": "Bikini Rosa",
      "precio": "25",
      "categoria": "Trajes de Baño",
      "imagen": "assets/traje_bano1.png",
      "descripcion": "Bikini de color rosa con diseño moderno y cómodo.",
    },
    {
      "nombre": "Bañador Entero Negro",
      "precio": "35",
      "categoria": "Trajes de Baño",
      "imagen": "assets/traje_bano2.png",
      "descripcion": "Bañador de una pieza con un diseño clásico y elegante.",
    },
    {
      "nombre": "Bikini Estampado",
      "precio": "27",
      "categoria": "Trajes de Baño",
      "imagen": "assets/traje_bano3.png",
      "descripcion": "Bikini con estampado tropical, ideal para la playa.",
    },

    // 🔹 Zapatos
    {
      "nombre": "Zapatos Urbanos",
      "precio": "50",
      "categoria": "Zapatos",
      "imagen": "assets/zapatos1.png",
      "descripcion": "Zapatos modernos y cómodos para un look casual.",
    },
    {
      "nombre": "Zapatos de Cuero",
      "precio": "80",
      "categoria": "Zapatos",
      "imagen": "assets/zapatos2.png",
      "descripcion":
          "Zapatos de cuero de alta calidad para ocasiones especiales.",
    },
    {
      "nombre": "Botines Negros",
      "precio": "90",
      "categoria": "Zapatos",
      "imagen": "assets/zapatos3.png",
      "descripcion":
          "Botines de cuero negro, perfectos para un estilo elegante.",
    },

    // 🔹 Accesorios
    {
      "nombre": "Collar de Plata",
      "precio": "20",
      "categoria": "Accesorios",
      "imagen": "assets/accesorio1.png",
      "descripcion": "Collar de plata con un diseño delicado y elegante.",
    },
    {
      "nombre": "Reloj Deportivo",
      "precio": "60",
      "categoria": "Accesorios",
      "imagen": "assets/accesorio2.png",
      "descripcion":
          "Reloj deportivo resistente al agua y con múltiples funciones.",
    },
    {
      "nombre": "Gafas de Sol",
      "precio": "35",
      "categoria": "Accesorios",
      "imagen": "assets/accesorio3.png",
      "descripcion": "Gafas de sol con protección UV y diseño moderno.",
    },
  ];

  List<Map<String, String>> carrito = [];

  void _agregarAlCarrito(Map<String, String> producto) {
    setState(() {
      carrito.add(producto); // ✅ Ahora actualiza la UI del carrito
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${producto['nombre']} agregado al carrito.")),
    );
  }

  void _mostrarDetalleProducto(
    BuildContext context,
    Map<String, String> producto,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close, size: 28, color: Colors.red),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  producto["imagen"]!,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                producto["nombre"]!,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                "${producto["categoria"]} - \$${producto["precio"]}",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                producto["descripcion"]!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _agregarAlCarrito(producto);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text(
                  "Agregar al carrito",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Productos"),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartPage(carrito: carrito),
                    ),
                  );
                },
              ),
              if (carrito
                  .isNotEmpty) // ✅ Mostrar solo si hay productos en el carrito
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      carrito.length.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: productos.length,
        itemBuilder: (context, index) {
          final producto = productos[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 3,
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  producto["imagen"]!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                producto["nombre"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "${producto["categoria"]} - \$${producto["precio"]}",
                style: const TextStyle(color: Colors.black54),
              ),
              trailing: const Icon(Icons.info_outline, color: Colors.blue),
              onTap: () {
                _mostrarDetalleProducto(context, producto);
              },
            ),
          );
        },
      ),
    );
  }
}

// 🛒 Carrito de Compras
class CartPage extends StatelessWidget {
  final List<Map<String, String>> carrito;

  const CartPage({super.key, required this.carrito});

  @override
  Widget build(BuildContext context) {
    // ✅ Calcular la suma total de los productos
    double total = carrito.fold(
      0,
      (sum, item) => sum + double.parse(item["precio"]!),
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Carrito de Compras")),
      body:
          carrito.isEmpty
              ? const Center(child: Text("El carrito está vacío"))
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: carrito.length,
                      itemBuilder: (context, index) {
                        final producto = carrito[index];
                        return Card(
                          child: ListTile(
                            leading: Image.asset(
                              producto["imagen"]!,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(producto["nombre"]!),
                            subtitle: Text(
                              "${producto["categoria"]} - \$${producto["precio"]}",
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Compra realizada con éxito"),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 30,
                        ),
                      ),
                      child: Text(
                        "Pagar \$${total.toStringAsFixed(2)}", // ✅ Mostrar el total en el botón
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
    );
  }
}

// UserProfilePage - Perfil del Usuario
class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  UserProfilePageState createState() => UserProfilePageState();
}

class UserProfilePageState extends State<UserProfilePage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoggedIn =
      false; // ✅ Estado para verificar si el usuario está autenticado

  // Simulación de datos de usuario
  final Map<String, String> _userData = {
    "nombre": "Edinson Aguirre",
    "correo": "edaguirre2@itb.edu.ec",
    "telefono": "+593959435217",
    "direccion": "Medardo Angel Silva y la 19",
    "historial": "Pedido #4598 - 15/02/2024\nPedido #6321 - 01/03/2024",
  };

  // Simulación de credenciales (puedes cambiarlo por una autenticación real)
  final String _validUser = "admin";
  final String _validPassword = "1234";

  void _login() {
    if (_userController.text == _validUser &&
        _passwordController.text == _validPassword) {
      setState(() {
        _isLoggedIn = true; // ✅ Usuario autenticado
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Usuario o contraseña incorrectos")),
      );
    }
  }

  void _logout() {
    setState(() {
      _isLoggedIn = false; // ✅ Cierra sesión
      _userController.clear();
      _passwordController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Perfil de Usuario")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _isLoggedIn ? _buildProfileView() : _buildLoginForm(),
      ),
    );
  }

  // 📌 Formulario de Inicio de Sesión
  Widget _buildLoginForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.person, size: 80, color: Colors.blue),
        const SizedBox(height: 20),
        TextField(
          controller: _userController,
          decoration: InputDecoration(
            labelText: "Usuario",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Contraseña",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _login,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
          child: const Text(
            "Iniciar Sesión",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ],
    );
  }

  // 📌 Vista del Perfil del Usuario
  Widget _buildProfileView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.person, size: 80, color: Colors.blue),
        const SizedBox(height: 20),
        _buildProfileItem("Nombre", _userData["nombre"]!),
        _buildProfileItem("Correo", _userData["correo"]!),
        _buildProfileItem("Teléfono", _userData["telefono"]!),
        _buildProfileItem("Dirección", _userData["direccion"]!),
        _buildProfileItem("Historial de Pedidos", _userData["historial"]!),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _logout,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
          child: const Text(
            "Cerrar Sesión",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ],
    );
  }

  // 📌 Widget para mostrar los datos del usuario
  Widget _buildProfileItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          Text(value, style: const TextStyle(fontSize: 16)),
          const Divider(),
        ],
      ),
    );
  }
}

// ContactPage - Información de Contacto
class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  // void _mostrarMensaje(BuildContext context) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(
  //       content: Text("Buscando dirección..."),
  //       duration: Duration(seconds: 3),
  //     ),
  //   );

  //   Future.delayed(const Duration(seconds: 3), () {
  //     if (context.mounted) {
  //       // ✅ Verifica que el contexto aún es válido
  //       Navigator.pop(context);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contacto de la Tienda")),
      body: Column(
        children: [
          // 🏬 Información de la Tienda
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "📍 Dirección:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Av. Principal 123, Ciudad, País",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                const Text(
                  "📞 Teléfono:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Text("+123 456 7890", style: TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                const Text(
                  "✉️ Email:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "contacto@tienda.com",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),

          // 🌍 Mapa Simulado (Imagen Local)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "assets/mapa_simulado.jpg", // ✅ Imagen local del mapa
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ),
            ),
          ),

          // 🗺️ Botón para simular búsqueda de dirección
          // Padding(
          //   padding: const EdgeInsets.all(20.0),
          //   child: ElevatedButton.icon(
          //     onPressed: () => _mostrarMensaje(context),
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: Colors.blue,
          //       padding: const EdgeInsets.symmetric(
          //         horizontal: 20,
          //         vertical: 15,
          //       ),
          //     ),
          //     icon: const Icon(Icons.map, color: Colors.white),
          //     label: const Text(
          //       "Buscar Dirección",
          //       style: TextStyle(fontSize: 18, color: Colors.white),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

// SupportPage - Soporte y Preguntas Frecuentes
class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  SupportPageState createState() => SupportPageState();
}

class SupportPageState extends State<SupportPage> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _solicitudController = TextEditingController();

  void _enviarSolicitud() {
    if (_nombreController.text.isEmpty || _solicitudController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor, completa todos los campos")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Solicitud enviada con éxito")),
      );
      _nombreController.clear();
      _solicitudController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Soporte y Ayuda")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 📝 Formulario de Soporte
              const Text(
                "📩 Formulario de Soporte",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _nombreController,
                decoration: InputDecoration(
                  labelText: "Nombre",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _solicitudController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Describe tu solicitud",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _enviarSolicitud,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                ),
                child: const Text(
                  "Enviar Solicitud",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),

              const SizedBox(height: 20),
              const Divider(thickness: 2), // 🔹 Línea de separación
              // ❓ Sección de Preguntas Frecuentes
              const SizedBox(height: 20),
              const Text(
                "❓ Preguntas Frecuentes",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ExpansionTile(
                title: const Text("📦 ¿Cuánto tarda en llegar mi pedido?"),
                children: const [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Los pedidos suelen tardar entre 3 y 7 días hábiles.",
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: const Text("💳 ¿Qué métodos de pago aceptan?"),
                children: const [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Aceptamos tarjetas de crédito, débito y PayPal.",
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: const Text("🔄 ¿Puedo devolver un producto?"),
                children: const [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Sí, tienes hasta 30 días para hacer devoluciones.",
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: const Text("🔒 ¿Es seguro comprar en su tienda?"),
                children: const [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Sí, nuestra tienda cuenta con encriptación SSL para proteger tus datos.",
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: const Text(
                  "📞 ¿Cómo puedo contactar con atención al cliente?",
                ),
                children: const [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Puedes contactarnos por correo a soporte@tienda.com o llamando al +123 456 7890.",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
