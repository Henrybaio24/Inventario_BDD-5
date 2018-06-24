-- Database: "Inventario"

-- DROP DATABASE "Inventario";

CREATE DATABASE "Inventario"
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'Spanish_Spain.1252'
       LC_CTYPE = 'Spanish_Spain.1252'
       CONNECTION LIMIT = -1;

CREATE TABLE personas
(
	"idPersona" int NOT NULL,
	nombre varchar(50) NOT NULL,
	apellido varchar(50) NOT NULL,
	teléfono varchar(10) NOT NULL,
	dirección varchar(300) NOT NULL,
	cedula varchar(10) NOT NULL,
	CONSTRAINT "idPersona" PRIMARY KEY ("idPersona")
);

CREATE TABLE personaNatural
(
	"idPerNatural" int NOT NULL,
	"idPersonaPers" int NOT NULL,
	cédula varchar(10) NOT NULL,
	CONSTRAINT "idPerNatural" PRIMARY KEY ("idPerNatural"),
	CONSTRAINT "idPersonaPers" FOREIGN KEY ("idPersonaPers")
	REFERENCES "personas" ("idPersona")
);

CREATE TABLE personasJuridicas
(
	"idPerJuridica" int NOT NULL,
	"idPersonaPers" int NOT NULL,
	ruc varchar(12) NOT NULL,
	CONSTRAINT "idPerJuridica" PRIMARY KEY ("idPerJuridica"),
	CONSTRAINT "idPersonaPers" FOREIGN KEY ("idPersonaPers")
	REFERENCES "personas" ("idPersona")
);

CREATE TABLE productos
(
	"idProducto" int NOT NULL,
	nombre varchar(50) NOT NULL,
	fechaCaducidad date NOT NULL,
	tipoProducto varchar(50) NOT NULL,
	unidades int NOT NULL,
	precio decimal NOT NULL,
	CONSTRAINT "idProducto" PRIMARY KEY ("idProducto")
);


CREATE TABLE proveedores
(
	"idProveedor" int NOT NULL,
	"idPersonaPers" int NOT NULL,
	nombre varchar(50) NOT NULL,
	CONSTRAINT "idProveedor" PRIMARY KEY ("idProveedor"),
	CONSTRAINT "idPersonaPers" FOREIGN KEY ("idPersonaPers")
	REFERENCES "personas" ("idPersona")
);



CREATE TABLE facturas
(
	"idFactura" int NOT NULL,
	nombreEmpresa varchar(100) NOT NULL,
	nombreCliente varchar(50) NOT NULL,
	dirección varchar(30) NOT NULL,
	cédula varchar(10) NOT NULL,
	teléfono varchar(20) NOT NULL,
	iva decimal NOT NULL,
	total decimal NOT NULL,
	CONSTRAINT "idFactura" PRIMARY KEY ("idFactura")
);

CREATE TABLE detallesFactura
(
	"idDetalleFactura" int NOT NULL,
	"produIdProducto" int NOT NULL,
	"facturaIdFactura" int NOT NULL,
	precio decimal NOT NULL,
	unidad int NOT NULL,
	CONSTRAINT "idDetalleFactura" PRIMARY KEY ("idDetalleFactura"),
	CONSTRAINT "produIdProducto" FOREIGN KEY ("produIdProducto")
	REFERENCES "productos" ("idProducto"),
	CONSTRAINT "facturaIdFactura" FOREIGN KEY ("facturaIdFactura")
	REFERENCES "facturas" ("idFactura")
);

CREATE TABLE clientes
(
	"idCliente" int NOT NULL,
	"idPersonaPers" int NOT NULL,
	CONSTRAINT "idCliente" PRIMARY KEY ("idCliente"),
	CONSTRAINT "idPersonaPers" FOREIGN KEY ("idPersonaPers")
	REFERENCES "personas" ("idPersona")
);

CREATE TABLE empleados
(
	"idEmpleado" int NOT NULL,
	"idPersonaPers" int NOT NULL,
	"facturaIdFactura" int NOT NULL,
	nombreCompraProducto varchar(50) NOT NULL,
	CONSTRAINT "idEmpleado" PRIMARY KEY ("idEmpleado"),
	CONSTRAINT "persona_idPersona" FOREIGN KEY ("idPersonaPers")
	REFERENCES "personas" ("idPersona"),
	CONSTRAINT "facturaIdFactura" FOREIGN KEY ("facturaIdFactura")
	REFERENCES "facturas" ("idFactura")
);

CREATE TABLE bodegas
(
	"idBodega" int NOT NULL,
	"productoIdProducto" int NOT NULL,
	nombreBodega varchar(50) NOT NULL,
	ubicaciónBodega varchar(100) NOT NULL,
	teléfono varchar(10) NOT NULL,
	email varchar(20) NOT NULL,
	CONSTRAINT "idBodega" PRIMARY KEY ("idBodega"),
	CONSTRAINT "producto_idProducto" FOREIGN KEY ("productoIdProducto")
	REFERENCES "productos" ("idProducto")
);

CREATE TABLE proveedoresPorBodega
(
	"idProveedorPorBodega" int NOT NULL,
	"bodegaIdBodega" int NOT NULL,
	"productoIdProducto" int NOT NULL,
	cantidad int NOT NULL,
	CONSTRAINT "idProveedorPorBodega" PRIMARY KEY ("idProveedorPorBodega"),
	CONSTRAINT "bodegaIddBodega" FOREIGN KEY ("bodegaIdBodega")
	REFERENCES "bodegas" ("idBodega"),
	CONSTRAINT "productoIdProducto" FOREIGN KEY ("productoIdProducto")
	REFERENCES "productos" ("idProducto")
);