-- UPDATE COMENTARIO --

CREATE TRIGGER [dbo].[create_comentario_update] ON [dbo].[COMENTARIO] FOR UPDATE AS 
BEGIN
    DECLARE @fecha_baja_vieja DATETIME,
            @fecha_baja_nueva DATETIME, 
            @id_publicacion INT

    SELECT @fecha_baja_vieja = FECHA_HORA_BAJA, @id_publicacion = ID_PUBLICACION FROM DELETED 
    SELECT @fecha_baja_nueva = FECHA_HORA_BAJA FROM INSERTED

    IF @fecha_baja_vieja IS NULL AND @fecha_baja_nueva IS NOT NULL
    BEGIN
        UPDATE PUBLICACION
        SET CANTIDAD_COMENTARIOS = CANTIDAD_COMENTARIOS - 1
        WHERE ID_PUBLICACION = @id_publicacion

        UPDATE COMENTARIO
        SET TEXTO = 'Eliminado', TIENE_IMAGEN = 0, IMAGEN = NULL 
        WHERE ID_PUBLICACION = @id_publicacion

        IF @@error != 0
        BEGIN
            RAISEERROR('No se pudo dar de baja el comentario', 1, 1) 
            ROLLBACK TRANSACTION
        END
    END
END

-- INSERT USUARIO TOPICO --

CREATE TRIGGER [dbo].[create_insert_usuario_topico] ON [dbo].[USUARIO_POR_SUBREDDIT] FOR INSERT AS 
BEGIN
    INSERT INTO TOPICO_POR_USUARIO
    SELECT ST.ID_TOPICO, I.ID_USUARIO, GETDATE(), NULL
    FROM INSERTED I
    INNER JOIN SUBREDDIT S ON I.ID_SUBREDDIT = S.ID_SUBREDDIT
    INNER JOIN SUBREDDIT_POR_TOPICO ST ON S.ID_SUBREDDIT = ST.ID_SUBREDDIT
    WHERE I.ID_SUBREDDIT = ST.ID_SUBREDDIT AND ST.FECHA_HORA_BAJA IS NULL

    IF @@error != 0
    BEGIN
        RAISEERROR('El usuario que ha ingresado al subreddit no ha sido insertado al topico.', 1, 1) 
        ROLLBACK TRANSACTION
    END
END

-- ADD CANTIDAD COMENTARIOS --

CREATE TRIGGER [dbo].[create_add_cantidad_comentarios] ON [dbo].[COMENTARIO] FOR INSERT AS 
BEGIN
    DECLARE @id_publicacion INT

    SELECT @id_publicacion = ID_PUBLICACION FROM INSERTED

    UPDATE PUBLICACION
    SET CANTIDAD_COMENTARIOS = CANTIDAD_COMENTARIOS + 1
    WHERE ID_PUBLICACION = @id_publicacion

    IF @@error != 0
    BEGIN
        RAISEERROR('No se pudo insertar el comentario', 1, 1) 
        ROLLBACK TRANSACTION
    END
END

-- VALIDATE USER'S POST --

CREATE TRIGGER [dbo].[create_publi_no_miembro_sr] ON [dbo].[PUBLICACION] FOR INSERT AS 
BEGIN
    DECLARE @usuario INT, 
            @subreddit INT, 
            @u_subreddit INT, 
            @id_subreddit INT 

    SELECT @usuario = ID_USUARIO, @subreddit = ID_SUBREDDIT FROM INSERTED 
    SELECT @id_subreddit = ID_SUBREDDIT FROM USUARIO_POR_SUBREDDIT
    WHERE @usuario = ID_USUARIO

    IF (@id_subreddit IS NULL)
    BEGIN
        RAISEERROR('Un usuario que no pertenece a un subreddit no puede publicar en el.', 8, 8) 
        ROLLBACK TRANSACTION
    END
END

-- UPDATE TOPICO --

CREATE TRIGGER [dbo].[create_update_topico] ON TOPICO FOR UPDATE AS 
BEGIN
    DECLARE @fecha_baja_vieja DATETIME,
            @fecha_baja_nueva DATETIME, 
            @id_topico INT

    SELECT @fecha_baja_nueva = FECHA_HORA_BAJA, @id_topico = ID_TOPICO FROM inserted
    SELECT @fecha_baja_vieja = FECHA_HORA_BAJA FROM deleted

    IF (@fecha_baja_nueva IS NOT NULL AND @fecha_baja_vieja IS NULL)
    BEGIN
        UPDATE TOPICO_POR_USUARIO
        SET FECHA_HORA_BAJA = @fecha_baja_nueva 
        WHERE ID_TOPICO = @id_topico

        UPDATE SUBREDDIT_POR_TOPICO
        SET FECHA_HORA_BAJA = @fecha_baja_nueva 
        WHERE ID_TOPICO = @id_topico

        IF @@error != 0
        BEGIN
            RAISEERROR('No se pudo insertar el comentario', 1, 1)
            ROLLBACK TRANSACTION
        END
    END
END

-- USUARIO X SUBREDDIT --

CREATE TRIGGER [dbo].[create_constancia_usuario_por_subreddit] ON USUARIO_POR_SUBREDDIT FOR INSERT AS 
BEGIN
    DECLARE @id_usuario INT,
            @id_subreddit INT,
            @fecha_baja_vieja DATETIME,
            @cant_usuarios DATETIME, 
            @id_usuario_x INT,
            @fec_alta DATETIME

    SELECT @id_usuario = ID_USUARIO, @id_subreddit = ID_SUBREDDIT, @fec_alta = FECHA_HORA_ALTA FROM INSERTED
    SELECT @fecha_baja_vieja = FECHA_HORA_BAJA, @id_usuario_x = ID_USUARIO FROM USUARIO_POR_SUBREDDIT 
    WHERE ID_USUARIO = @id_usuario AND ID_SUBREDDIT = @id_subreddit AND FECHA_HORA_ALTA != @fec_alta

    IF @fecha_baja_vieja IS NULL AND @id_usuario_x IS NOT NULL
    BEGIN
        RAISEERROR ('El usuario ya está activado en este subreddit', 16, 1) 
        ROLLBACK TRANSACTION
    END
END