-- USO PREMIOS POR RANGO --

CREATE PROCEDURE [dbo].[usp_premios_por_rango]
AS 
BEGIN
    DECLARE @cant_prem_otorgados INT, @cant_usuarios INT

    SELECT
        RANGO_ETARIO.NOMBRE as 'Rango etario',
        ROUND ((CONVERT(FLOAT, COUNT(premio_por_usuario.id_usuario_otorga))/COUNT(DISTINCT(usuario.id_usuario))*100), 2) as 'Premios otorgados por usuario en promedio en %',
        COUNT(premio_por_usuario.id_usuario_otorga) as 'Cantidad premios otorgados',
        COUNT(DISTINCT(usuario.id_usuario)) as 'Cantidad usuarios'
    FROM usuario
    LEFT JOIN premio_por_usuario ON premio_por_usuario.id_usuario_otorga = usuario.id_usuario
    RIGHT JOIN rango_etario ON rango_etario.id_rango_etario = usuario.id_rango_etario
    GROUP BY rango_etario.NOMBRE
    ORDER BY CONVERT(FLOAT, COUNT (premio_por_usuario.id_usuario_otorga))/COUNT (DISTINCT (usuario.id_usuario)) DESC
END

-- OBTENER REGIONES PARA EXPANDIR --

CREATE PROCEDURE [dbo].[usp_obt_reg_para_expandir]
AS 
BEGIN
    SELECT 
        REGION.ID_REGION, 
        REGION.NOMBRE, 
        ROUND((REGION.HABITANTES/CONVERT(FLOAT, USUARIOS_REGION.Usuarios)), 2) AS "Habitantes por usuario" 
    FROM REGION
    JOIN (
        SELECT REGION.ID_REGION, COUNT (USUARIO.ID_USUARIO) AS 'Usuarios'
        FROM USUARIO
        LEFT JOIN PAIS ON USUARIO.ID_PAIS = PAIS.ID_PAIS
        LEFT JOIN REGION ON PAIS.ID_REGION = REGION.ID_REGION
        GROUP BY REGION.ID_REGION
    ) USUARIOS_REGION ON REGION.ID_REGION = USUARIOS_REGION.ID_REGION
    ORDER BY "Habitantes por usuario" DESC
END

-- NUEVOS USUARIOS --

CREATE PROCEDURE [dbo].[usp_new_users] 
    @since DATETIME, 
    @to DATETIME
AS 
BEGIN
    SELECT 
        YEAR(USUARIO.FECHA_HORA_ALTA) AS Ano, 
        RANGO_ETARIO.NOMBRE, 
        COUNT(USUARIO.ID_USUARIO) AS Cantidad_Usuarios_Nuevos 
    FROM USUARIO
    LEFT JOIN RANGO_ETARIO ON USUARIO.ID_RANGO_ETARIO = RANGO_ETARIO.ID_RANGO_ETARIO
    WHERE YEAR(USUARIO.FECHA_HORA_ALTA) BETWEEN YEAR(@since) AND YEAR(@to)
    GROUP BY YEAR(USUARIO.FECHA_HORA_ALTA), RANGO_ETARIO.NOMBRE
    ORDER BY YEAR(USUARIO.FECHA_HORA_ALTA) DESC, COUNT(USUARIO.ID_USUARIO) DESC
END

-- OBTENER SUBREDDITS POPULARES POR PAÍS --

CREATE PROCEDURE [dbo].[usp_obtener_subreddits_populares_por_pais] 
    @pais VARCHAR(100)
AS 
BEGIN
    DECLARE @interaccion_por_publicacion INT = 10
    DECLARE @interaccion_por_comentario INT = 0
    DECLARE @interaccion_por_voto INT = 1
    DECLARE @id_pais INT

    SELECT @id_pais = id_pais FROM pais WHERE nombre = @pais

    DECLARE @interaccion_total INT

    DECLARE @interaccion_por_subreddit TABLE (interaccion_total INT, id_sub INT)

    INSERT INTO @interaccion_por_subreddit
    SELECT 
        ( @interaccion_por_publicacion * COUNT(DISTINCT(publicacion.id_publicacion)) + 
          @interaccion_por_comentario * COUNT(DISTINCT(comentario.id_comentario)) + 
          @interaccion_por_voto * COUNT(DISTINCT(voto.ID_VOTO))
        ), 
        subreddit.id_subreddit 
    FROM subreddit
    INNER JOIN usuario_por_subreddit ON subreddit.id_subreddit = usuario_por_subreddit.id_subreddit
    INNER JOIN usuario ON usuario_por_subreddit.id_usuario = usuario.id_usuario
    LEFT JOIN pais ON pais.id_pais = usuario.id_pais
    FULL JOIN publicacion ON publicacion.id_usuario = usuario.id_usuario
    FULL JOIN comentario ON usuario.id_usuario = comentario.id_usuario
    FULL JOIN voto ON usuario.id_usuario = voto.id_usuario
    WHERE subreddit.fecha_hora_baja IS NULL AND pais.id_pais = @id_pais
    GROUP BY subreddit.id_subreddit
    HAVING COUNT(publicacion.id_publicacion) > 0

    SELECT 
        SUBREDDIT.ID_SUBREDDIT, 
        SUBREDDIT.NOMBRE, 
        id_subs.interaccion_total AS "Interaccion Total", 
        SUBREDDIT.DESCRIPCION, 
        SUBREDDIT.CANTIDAD_MIEMBROS, 
        SUBREDDIT.FECHA_HORA_ALTA 
    FROM SUBREDDIT
    JOIN @interaccion_por_subreddit AS id_subs ON SUBREDDIT.ID_SUBREDDIT = id_subs.id_sub
    ORDER BY "Interaccion Total" DESC, SUBREDDIT.CANTIDAD_MIEMBROS DESC
END

-- HORARIO TOP PUBLICACION POR REGIÓN --

CREATE PROCEDURE [dbo].[usp_horario_top_publicacion_x_region] 
    @id_region VARCHAR(100), 
    @fecha_hora_alta_popular DATETIME OUTPUT
AS 
BEGIN
    SELECT TOP 1 @fecha_hora_alta_popular = PUBLICACION.FECHA_HORA_ALTA
    FROM PUBLICACION
    INNER JOIN VOTO ON PUBLICACION.ID_PUBLICACION = VOTO.ID_PUBLICACION
    INNER JOIN USUARIO ON PUBLICACION.ID_USUARIO = USUARIO.ID_USUARIO
    INNER JOIN PAIS ON USUARIO.ID_PAIS = PAIS.ID_PAIS
    INNER JOIN REGION ON PAIS.ID_REGION = REGION.ID_REGION
    WHERE region.id_region = @id_region
    GROUP BY PUBLICACION.ID_PUBLICACION
    ORDER BY COUNT(VOTO.ID_VOTO) DESC
END