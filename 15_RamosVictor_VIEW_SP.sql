-- Ponemos en uso la base de datos dbMesajil
USE dbMesajil;
GO


-- Listar los datos de los productos con los datos de los clientes a los que se ha realizado la venta, incluyendo el detalle de la venta.
CREATE VIEW vClienteProducto
AS
SELECT 
	BD.CANTBODE AS 'Cantidad del Producto',
	EI.NOMEI AS 'Nombre del Equipo Informatico',
	EI.MAREI AS 'Marca del Equipo Informatico',
	C.NOMCLI AS 'Nombre del Cliente',
	C.APECLI AS 'Apellido del Cliente'
FROM BOLETA_DETALLE AS BD
	INNER JOIN EQUIPO_INFORMATICOS AS EI ON
	EI.IDEI = BD.IDEI
	INNER JOIN BOLETA AS B ON
	B.IDBOLE = BD.IDBOLE
	INNER JOIN CLIENTE AS C ON
	C.IDCLI = B.IDCLI
GO

SELECT * FROM vClienteProducto
GO

/* Listar los clientes que han comprado en el ultimo mes */
CREATE VIEW vClientesMes
AS 
SELECT 
    B.IDBOLE AS 'ID de Boleta',
	FORMAT(B.FECHBOLE, 'd', 'es_ES') AS 'Fecha de Venta',
    C.NOMCLI AS 'Nombre del Cliente',
    C.APECLI AS 'Apellido del Cliente'
FROM BOLETA AS B
    INNER JOIN CLIENTE AS C ON 
    B.IDCLI = C.IDCLI
WHERE 
    MONTH(B.FECHBOLE) = 06
AND
	YEAR(B.FECHBOLE) = 2021
AND
	B.ESTBOLE = 'A'
GO

/* Listar los registros de la vista vClientesFrecuentes */
SELECT * FROM vClientesMes
GO


-- Listar el tipo de Cliente que ha comprado el producto y su respectivo cliente
CREATE VIEW vVentaDetalle
AS
SELECT
	B.FECHBOLE AS 'Fecha',
--	P.NOMPROV AS 'Proveedor',
	--P.TIPPROV AS 'Tipo de Proveedor',
	EI.NOMEI AS 'Nombre del Equipo',
	EI.MAREI AS 'Marca del Equipo',
	E.NOMEMP AS 'Nombre del Empleado',
	E.APEEMP 'Apellido del Empleado',
    C.NOMCLI AS 'Nombre del Cliente',
    C.APECLI AS 'Apellido del Cliente'
FROM BOLETA_DETALLE AS BD
	INNER JOIN BOLETA AS B ON
	B.IDBOLE = BD.IDBOLE
	INNER JOIN EMPLEADO AS E ON
	E.IDEMP = B.IDEMP
	INNER JOIN EQUIPO_INFORMATICOS AS EI ON
	EI.IDEI = BD.IDEI
    INNER JOIN CLIENTE AS C ON
    C.IDCLI = B.IDCLI
GO

SELECT * FROM vVentaDetalle
GO


/* Procedimiento almacenado para Insertar Clientes y que no haya duplicado de DNI */
CREATE PROCEDURE spInsertCliente
    (
        @nombreCli      VARCHAR(80),
        @apellidoCli    VARCHAR(80),
        @dniCli         CHAR(8),
		@estadoCli		CHAR(1)
    )
AS
    BEGIN
    SET NOCOUNT ON
        BEGIN TRY
        begin tran;
            IF(SELECT COUNT(*) FROM dbo.CLIENTE AS C WHERE C.DNICLI = @dniCli) = 1
                ROLLBACK TRAN;
            ELSE
                INSERT INTO dbo.CLIENTE
                    (NOMCLI, APECLI, DNICLI, ESTCLI)
                VALUES
                    (@nombreCli, @apellidoCli, @dniCli, @estadoCli)
        COMMIT TRAN;
        END TRY
        BEGIN CATCH
            SELECT 'El cliente ya existe.' AS 'ERROR'
            IF @@TRANCOUNT > 0 ROLLBACK TRAN;
        END CATCH
    END
GO



/* Procedimiento almacenado para insertar VENDEDOR y validar que no se ingrese duplicado de número DNI */
CREATE PROCEDURE spInsertVendedor
(
    @NombreEmpleado VARCHAR(30),
    @ApellidoEmpleado VARCHAR(30),
    @DniEmpleado CHAR(8),
	@TelefonoEmpleado CHAR(9),
    @DireccionEmpleado VARCHAR(50),
	@SucursalEmpleado VARCHAR(6),
	@UsuarioEmpleado INT,
    @EstadoEmpleado VARCHAR(1)
)
AS
    BEGIN
        BEGIN TRAN
        BEGIN TRY
            IF (SELECT COUNT(*) FROM dbo.EMPLEADO AS V WHERE V.DNIEMP = @DniEmpleado) = 1
                ROLLBACK TRAN
            ELSE
                INSERT INTO dbo.EMPLEADO
                (NOMEMP, APEEMP, DNIEMP, TELFEMP, DIREMP, IDSUC, IDUSU, ESTEMP)
                VALUES
                (@NombreEmpleado, @ApellidoEmpleado, @DniEmpleado, @TelefonoEmpleado, @DireccionEmpleado, @SucursalEmpleado, @UsuarioEmpleado, @EstadoEmpleado)
                COMMIT TRAN
        END TRY
        BEGIN CATCH
            SELECT 'Este vendedor ya ha sido registrado.' AS 'ERROR'
                IF @@TRANCOUNT > 0 ROLLBACK TRAN; 
        END CATCH
    END
GO
