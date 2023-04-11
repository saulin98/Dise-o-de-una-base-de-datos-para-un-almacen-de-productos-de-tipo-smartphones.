-- create database proyecto_final_Saul;

-- Creacion de las tablas

Create table Cliente (
ClienteId int auto_increment not null,
ClienteNom varchar(100),
ClienteDir varchar(150),
ClienteTel varchar(25),
ClienteRFC varchar(25),
primary key(ClienteId)
)engine=InnoDB;

create table Proveedor(
ProveedorId int auto_increment not null,
ProveedorNom varchar(100),
ProveedorDir varchar(150),
ProveedorRFC varchar(25),
primary key(proveedorId)
)engine=InnoDB;

create table Sucursal (
SucursalId int auto_increment not null,
SucursalNom varchar(100),
SucursalDir varchar(150),
primary key (SucursalId)
)engine=InnoDB;

create table TipoProducto (
tPId int auto_increment not null,
tPNombre varchar(100),
tPDesc varchar(150),
primary key(tPId),
FK_Proveedor int not null,
constraint FKTipoProducto_Proveedor
foreign key (FK_Proveedor) references proveedor (ProveedorId)
)engine=InnoDB;

create table Producto(
ProductoId int auto_increment not null,
ProductoNombre varchar(100),
ProductoDesc varchar(220),
ProductoPrecio double ,
primary key(ProductoId),
tPId int not null,
constraint FKProducto_TipoProducto 
foreign key (tPId) references tipoproducto(tPId),
tiendaId int not null,
constraint FKProducto_Sucursal
foreign key(tiendaId) references sucursal(SucursalId)
)engine=InnoDB;

create table Ventas(
VentaID int auto_increment not null,
TotalVenta double ,
FechaVenta date,
SucursalId int not null,
primary key(VentaID,SucursalId),
FK_Cliente int not null,
constraint FKVentas_Cliente
foreign key (FK_Cliente) references Cliente (ClienteId),
-- llave foranea compuesta
KEY fk_Venta_Sucursal_idx (SucursalId),
CONSTRAINT fk_Venta_Sucursal FOREIGN KEY (SucursalId) REFERENCES sucursal (SucursalId)
)engine=InnoDB;

create table Devolucion(
DevID int auto_increment not null,
FechaDev date,
TotalDev double,
primary key(DevID),
FK_Venta int not null,
constraint FKDevolucion_Venta
foreign key (FK_Venta) references ventas(VentaID),
FK_Sucursal int not null,
constraint FKDevolucion_Sucursal
foreign key (FK_Sucursal) references sucursal(SucursalId)
)engine=InnoDB;

create table ProductoVenta(
pvId int auto_increment not null,
primary key (pvId),
FK_Producto int not null,
constraint FKProductoVenta_Producto
foreign key(FK_Producto) references producto(ProductoId),
FK_Venta int not null,
constraint FKProductoVenta_Venta
foreign key(FK_Venta) references ventas(VentaID),
FK_Sucursal int not null,
constraint FKProductoVenta_Sucursal
foreign key(FK_Sucursal) references sucursal(SucursalId)
)engine=InnoDB;

create table DevProducto (
dpId int auto_increment not null,
primary key(dpId),
FK_pvId int not null,
constraint FKDevProducto_ProductoVenta
foreign key(FK_pvId) references productoventa(pvId),
FK_devId int not null,
constraint FKDevProducto_Devolucion
foreign key(FK_devId) references devolucion(DevID)
)engine=InnoDB;

create table Traspaso(
traspasoId int auto_increment not null,
fecha date,
primary key (traspasoId),
FK_SucursalIdOrin int not null,
constraint FKTraspaso_SucursalIdOrin
foreign key (FK_SucursalIdOrin) references sucursal(SucursalId),
FK_SucursalIdDest int not null,
constraint FKTraspaso_SucursalIdDest
foreign key (FK_SucursalIdDest) references sucursal(SucursalId)
)engine=InnoDB;

create table TraspasoProducto (
   idTrPr  int auto_increment not null,
   FK_traspaso	int not null,
   FK_Producto int not null,
  primary key (idTrPr,FK_traspaso,FK_Producto),
  key FKTraspasoProducto_idx (FK_Producto),
  constraint  FKTraspaso_Producto
  foreign key (FK_traspaso) references traspaso(traspasoId),
  key FKProductoTraspaso_idx (FK_traspaso),
  constraint FKProducto_Traspaso 
  foreign key (FK_Producto) references producto(ProductoId)
) engine=InnoDB;

-- 1.-Llene las tablas Proveedor, tipoProducto, cliente, y sucursal con al menos 5 instancias.

insert into Proveedor(ProveedorNom,ProveedorDir,ProveedorRFC) 
values ("Samsung","VIA LOPEZ PORTILLO 6, SAN FRANCISCO CHILPAN,TULTITLÁN,MÉXICO 54940","SEM-950215-S98"),
       ("Huawei", "Av. Santa Fe 440, Lomas de Santa Fe, Contadero, Cuajimalpa de Morelos, 05348 Ciudad de México, CDMX","HTM-011012-DW7"),
       ("Apple","Avenida Vasco de Quiroga 3800 Lomas de Santa Fe, Antigua Mina de Totolapa CP 05109 - Del. Cuajimalpa (CDMX)","AOM920820BEA"),
       ("LG", "SOR JUANA INES DE LA CRUZ/555// Tlalnepantla de Baz Ciudad Tlalnepantla de Baz Edo.Mexico C.P 54033","LEM9308114C4"),
       ("Motorola","Bosque de Alisos,125,N/A, Bosques de Las Lomas,MÉXICO D.F.,05120,Miguel Hidalgo,Mexico","MME-781231-A76");


insert into tipoproducto(tPNombre,tPDesc,FK_Proveedor) 
            values("Smartphone","Procesador,RAM,Almacenamiento,Pantalla",5),
                  ("Tablet","Procesador,RAM,Almacenamiento,Pantalla",2),
                  ("SmartWatch","Procesador,RAM,Almacenamiento,Pantalla",1),
           	  ("VRGlasses","Sensores",4),
          	  ("¡Pad","Procesador,RAM,Almacenamiento,Pantalla",3);  


insert into cliente(ClienteNom,ClienteDir,ClienteTel,ClienteRFC) 
values ("Luis Torres Garza","Calle 5 de mayo,num.212,Col.Paraiso, C.P.2123,Delegacion Benito Juarez,Cdmx","762-324-8891","TOGA980212CL7"),
       ("Jose Franco Ruiz","Calle Palomares,num.90,Col.Palomas,C.P.1131,Ecatepec de Morelos,Edo.Mexico","552-431-2210","FRRU790410CH7"),
       ("Maximo Cruz Padilla","Calle Rosario,num.32,Col.Roma,C.P.1093,Delegacion Cuahutemoc,Cdmx","551-320-4025","CRPA710111KJ3"),
       ("Miguel Morales Juarez","Calle Morelos,num.12,Col.Granjas,C.P.7324,Delegacion Azcapotzalco,Cdmx","881-123-1280","MOJU900221MP1"),
        ("Maria Dominguez Rosete","Calle Adolfo Lopez Mateos,num.54,C.P.2043,Col.Lomas de chapultepec,Delegacion Miguel Hidalgo","776-123-9018","DORO790802JW4");


insert into sucursal(SucursalNom,SucursalDir) 
      values ("Polanco","Av. Pdte. Masaryk 419, Polanco, Polanco IV Secc, Miguel Hidalgo, 11550 Ciudad de México, CDMX"),
              ("Reforma 222", "Av. Paseo de la Reforma 222, Juárez, Cuauhtémoc, 06600 Ciudad de México, CDMX"),
              ("Venustino Carranz","Amb, Av. Capitán Carlos León Local 101, Peñón de los Baños, Venustiano Carranza, 15520 Ciudad de México, CDMX"),
               ("Buenavista","Eje 1 Nte. 259, Buenavista, Cuauhtémoc, 06350 Ciudad de México, CDMX"),
               ("Centro Coyoacan","Av. Coyoacán #2000, Planta Baja Col, Xoco, 03330 Ciudad de México");
 
-- 2.-Llene las tablas Producto, Venta y Traspaso con al menos 10 instancias.
-- 3.-Llene las tablas Producto, Venta y Traspaso con al menos 10 instancias.
-- El punto 2 y el 3 los inclui en un solo paso

insert into producto(ProductoNombre,ProductoDesc,ProductoPrecio,tPId,tiendaId)
    values("Moto G30","procesador:Snapdragon 662 de Qualcomm,RAM:6GB,128GB de almacenamiento interno expandible,La pantalla: 6.5 pulgadas a resolución HD+ con una tasa de refresco mejorada de 90Hz",4999,1,2),
          ("Moto G100","procesador:Snapdragon 870 de Qualcomm,RAM:8GB,128GB de almacenamiento interno expandible,pantalla full HD+ de 6.7 pulgadas con tasa de refresco de 90Hz	",12999,1,3),
	  ("Moto G20","procesador:Unisoc T700 de ocho núcleos,RAM:4GB,64GB de espacio de almacenamiento expandible vía microSD,pantalla HD+ de 6.5 pulgadas con tasa de refresco de 90 Hz",4599,1,1),
	  ("MatePad Pro 12.6in","procesador:Kirin 990 2.86GHz,RAM:6GB/8GB,Almacenamiento: 128GB/256GB/512GB,cámaras de 13 MP y 8 MP, atrás y al frente respectivamente, parlantes stereo, batería:7250 mAh,Android 10",15999,2,1),
 	  ("MatePad 11 10.96in","procesador:Snapdragon 865 de Qualcomm,RAM:6 GB,Almacenamiento:64GB/128GB,Pantalla dividida multi-screen con un portátil",11999,2,2),
	  ("Galaxy Watch4 Bluetooth (44 mm)","procesador:Exynos W920,RAM:1.5GB,Almacenamiento:16 GB,Bluetooth 5.0. NFC,Pantalla:1.36in,450 x 450 píxeles",5999,3,4),
	  ("Galaxy Watch Active2 (40 mm)","procesador:Exynos 9110 de dos núcleos,RAM:1.5GB,Almacenamiento:4GB ,Pantalla: 1.2in,360 x 360 pixels",4999,3,3),  
	  ("LG 360 VR","Light Blocker,Tamaño:164.1 x 185.6 x 45.9 mm,Giróscopo,Acelerómetro,Sensor de proximidad",200,4,1),
	  ("iPad Air","procesador:Apple A7 de 2 nucleos con Velocidad de 1.30 Mhz,RAM:1GB,Almacenamiento:128 GB ,Pantalla:9,70in,resolucion 2048 X 1536",16499,5,5),
	  ("iPad Pro","procesador:M1 de Apple de de 8 núcleos, RAM:8GB, Almacenamiento:128GB/256GB/512GB/1TB/2TB Pantalla: 11in,resolucion  2388 x 1668",20999,5,5),
       ("Moto G50","procesador:Snapdragon 662 de Qualcomm,RAM:6GB,128GB de almacenamiento interno expandible,La pantalla: 6.5 pulgadas a resolución HD+ con una tasa de refresco mejorada de 90Hz",4999,1,2),
	  ("Moto G60","procesador:Snapdragon 870 de Qualcomm,RAM:8GB,128GB de almacenamiento interno expandible,pantalla full HD+ de 6.7 pulgadas con tasa de refresco de 90Hz	",12999,1,3),
	  ("Moto G70","procesador:Unisoc T700 de ocho núcleos,RAM:4GB,64GB de espacio de almacenamiento expandible vía microSD,pantalla HD+ de 6.5 pulgadas con tasa de refresco de 90 Hz",4599,1,1),
	  ("MatePad Elite 12.6in","procesador:Kirin 990 2.86GHz,RAM:6GB/8GB,Almacenamiento: 128GB/256GB/512GB,cámaras de 13 MP y 8 MP, atrás y al frente respectivamente, parlantes stereo, batería:7250 mAh,Android 10",15999,2,1),
 	  ("MatePad 12 10.96in","procesador:Snapdragon 865 de Qualcomm,RAM:6 GB,Almacenamiento:64GB/128GB,Pantalla dividida multi-screen con un portátil",11999,2,2),
	  ("Galaxy Watch5 Bluetooth (44 mm)","procesador:Exynos W920,RAM:1.5GB,Almacenamiento:16 GB,Bluetooth 5.0. NFC,Pantalla:1.36in,450 x 450 píxeles",5999,3,4),
	  ("Galaxy Watch3 Active1 (40 mm)","procesador:Exynos 9110 de dos núcleos,RAM:1.5GB,Almacenamiento:4GB ,Pantalla: 1.2in,360 x 360 pixels",4999,3,3),  
	  ("LG 360 VR PRO","Light Blocker,Tamaño:164.1 x 185.6 x 45.9 mm,Giróscopo,Acelerómetro,Sensor de proximidad",200,4,1),
	  ("iPad Air lite","procesador:Apple A7 de 2 nucleos con Velocidad de 1.30 Mhz,RAM:1GB,Almacenamiento:128 GB ,Pantalla:9,70in,resolucion 2048 X 1536",16499,5,5),
	  ("iPad Pro 11","procesador:M1 de Apple de de 8 núcleos, RAM:8GB, Almacenamiento:128GB/256GB/512GB/1TB/2TB Pantalla: 11in,resolucion  2388 x 1668",20999,5,5);
		 

insert into ventas(TotalVenta,FechaVenta,SucursalId,FK_Cliente)
	    values(20999,"2020-07-20",4,2),
		(16499,"2021-01-01",5,4),
		(5999,"2021-01-06",4,3),
		(4999,"2021-12-25",2,5),
		(12999,"2021-10-06",3,1),
		(5999,"2021-11-28",4,3),
		(20598,"2021-10-16",1,4),
		(11999,"2021-07-20",2,4),
		(200,"2021-05-10",1,1),
		(20999,"2021-04-18",5,2),
		(17998,"2021-05-06",3,1),
		(12999,"2021-09-20",3,2),
		(4999,"2021-03-22",2,4),
		(20598,"2021-07-14",1,1),
		(4999,"2021-05-10",3,3),
		(200,"2021-06-06",1,1),
		(12999,"2021-03-18",3,2),
        	(20598,"2021-05-10",1,1),
		(4999,"2021-06-06",3,3);
		
insert into traspaso(fecha,FK_SucursalIdOrin,FK_SucursalIdDest)
			values("2021-03-17",1,3),
			      ("2021-02-10",3,2),
			      ("2021-01-20",2,1),
			      ("2021-07-11",1,5),
				("2021-03-12",4,3),
				("2021-02-26",4,1),
				("2021-03-21",3,1),
				("2021-03-22",2,5),
				("2021-09-19",4,1),
				("2021-02-17",4,5),
				("2021-03-15",3,2),
				("2021-04-08",2,1),
				("2021-05-20",2,1),
				("2021-07-13",1,5),
				("2021-02-20",4,3),
				("2021-12-26",4,1),
				("2021-03-25",3,1),
				("2021-03-22",2,5),
				("2021-06-19",4,1),
				("2021-02-19",4,5),
				("2021-06-15",3,2),
				("2021-09-08",2,1);


-- 4.-Llene las tablas Producto/Venta y Traspaso/Producto con al menos 20 instancias.

 	insert into productoventa(FK_Producto,FK_Venta,FK_Sucursal) 
		values (10,1,5),	
			(9,2,5),
			(6,3,4),
			(1,4,2),
			(2,5,3),
			(6,6,4),
			(4,7,1),
			(3,7,1),
			(5,8,2),
			(8,9,1),
			(10,10,5),
			(2,11,3),
			(7,11,3),
			(2,12,3),
			(1,13,2),
			(3,14,1),
			(4,14,1),
			(7,15,3),
			(8,16,1),
			(2,17,3);


insert into traspasoproducto(FK_traspaso,FK_Producto) 
					values (1,3),
						(2,2),
						(2,7),
						(3,1),
						(3,5),
						(4,3),
						(5,9),
						(5,10),
						(5,6),
						(6,6),
						(7,2),
						(7,7),
						(8,5),
						(8,1),
						(8,1),
						(9,6),
						(10,6),
						(11,7),
						(11,2),
						(12,5);

-- 5.-Llene las tablas Devolución con 1 instancia y dev/Producto con al menos 1 instancia.

insert into devolucion(FechaDev,TotalDev,FK_Venta,FK_Sucursal)
					values("2020-01-20",12999,5,3);

 insert into devproducto(FK_pvId,FK_devId)
					values(2,1);

-- 6.-Genere una vista de los productos más vendidos. Para ello considere mostrar productoId, productoNombre, productoDescripcio, proveedorNombre y tPNombre.

create view Producto_Mas_Vendidos as select producto.ProductoId,producto.ProductoNombre,producto.ProductoDesc,
proveedor.ProveedorNom,tipoproducto.tPNombre,count(*)  from producto 
inner join tipoproducto inner join productoventa inner join proveedor
 on producto.tPId=tipoproducto.tPId 
 where producto.tiendaId=productoventa.FK_Sucursal
 and proveedor.ProveedorId=tipoproducto.tPId
 group by tipoproducto.tPId ;

 -- select * from producto_mas_vendidos;

-- 7.-Genere una función que permita obtener el tPNombre del producto más vendido.

DELIMITER //
 CREATE FUNCTION P_M_V () RETURNS varchar(100)
 deterministic
 BEGIN
 DECLARE nombre varchar(100);
 SELECT tPNombre INTO nombre FROM producto_mas_vendidos where
producto_mas_vendidos.`count(*)`= (select max(producto_mas_vendidos.`count(*)`) 
from producto_mas_vendidos);
 RETURN nombre;
 END//DELIMITER ;
 
 -- select P_M_V() tPNombre;

-- 8.-Genere un procedimiento que muestre todos los productos de un proveedor con base en el nombre del proveedor.

DELIMITER //
 CREATE PROCEDURE productos_de_proveedor(in proveedor varchar(220))
BEGIN
 select ProductoNombre from proveedor inner join tipoproducto inner join producto 
on ProveedorId=tipoproducto.FK_Proveedor where tipoproducto.tPId=producto.tPId and
    proveedor.ProveedorNom=proveedor;
END//
 DELIMITER ; 
 
-- call productos_de_proveedor("Apple");

-- 9.-Genere una tabla llamada DevRespaldo con los campos: DervrespaldoID, DevID, VentaID, SucursalID, FechaDev, TotalDev, Sucursal, Usuario.

create table DevRespaldo (
DervrespaldoID int auto_increment not null,
DevID int,
FechaDev date,
TotalDev double,
VentaID int,
SucursalID int,
SucursalNombre varchar(150),
Usuario varchar(50),
primary key(DervrespaldoID)
)engine=innoDB;

-- 10.-Genere un trigger en la tabla Devolución de modo que al eliminar un registro de esta, dicho registro se guarde en la tala RespaldoDev y 
-- que al mismo tiempo elimine los registros asociados en Dev/Producto.


delimiter //
create function nomSuc (idSuc int) returns varchar(150)
deterministic
begin
declare X varchar(150);
select sucursal.SucursalNom into X from sucursal where sucursal.SucursalId=idSuc;
return X; 
end // delimiter ;


delimiter //
create trigger Respaldo
before delete 
on devolucion for each row
begin
insert into devrespaldo(DevID,FechaDev,TotalDev,VentaID,SucursalID)
 select * from devolucion where DevID=old.DevID;
 update devrespaldo set SucursalNombre=nomSuc(VentaID),Usuario=current_user() where DevID=old.DevID;
 delete from devproducto where devproducto.FK_devId=old.DevID;
end // delimiter ;

-- Para poder borrar el registro con dependencias, configure las FK de la tabla devolucion y le puese en la opcion cascada para delete

-- Nota: en algunas instancias de venta , coloque mas de un producto asociado a una venta

