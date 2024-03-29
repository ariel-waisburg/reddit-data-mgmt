CREATE TABLE [dbo].[RANGO_ETARIO](
	[ID_RANGO_ETARIO] [int] NOT NULL,
	[NOMBRE] [varchar](30) NOT NULL,
	[DESCRIPCION] [varchar](250) NOT NULL,
 CONSTRAINT [RANGO_ETARIO_PK] PRIMARY KEY CLUSTERED 
(
	[ID_RANGO_ETARIO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[PUBLICACION](
	[ID_PUBLICACION] [int] NOT NULL,
	[ID_USUARIO] [int] NULL,
	[ID_SUBREDDIT] [int] NOT NULL,
	[TITULO] [varchar](100) NOT NULL,
	[FECHA_HORA_ALTA] [datetime] NOT NULL,
	[TIENE_IMAGEN] [bit] NOT NULL,
	[TIENE_ENCUESTA] [bit] NOT NULL,
	[IMAGEN] [varchar](100) NULL,
	[TEXTO] [varchar](8000) NULL,
	[CANTIDAD_COMENTARIOS] [int] NULL,
	[FECHA_HORA_BAJA] [datetime] NULL,
 CONSTRAINT [PUBLICACION_PK] PRIMARY KEY CLUSTERED 
(
	[ID_PUBLICACION] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PUBLICACION]  WITH CHECK ADD  CONSTRAINT [PUBLICACION_SUBREDDIT_FK] FOREIGN KEY([ID_SUBREDDIT])
REFERENCES [dbo].[SUBREDDIT] ([ID_SUBREDDIT])
GO
ALTER TABLE [dbo].[PUBLICACION] CHECK CONSTRAINT [PUBLICACION_SUBREDDIT_FK]
GO
ALTER TABLE [dbo].[PUBLICACION]  WITH CHECK ADD  CONSTRAINT [PUBLICACION_USUARIO_FK] FOREIGN KEY([ID_USUARIO])
REFERENCES [dbo].[USUARIO] ([ID_USUARIO])
GO
ALTER TABLE [dbo].[PUBLICACION] CHECK CONSTRAINT [PUBLICACION_USUARIO_FK]
GO
ALTER TABLE [dbo].[PUBLICACION]  WITH CHECK ADD  CONSTRAINT [CK_Cantidad_Comentarios] CHECK  (([CANTIDAD_COMENTARIOS]>=(0)))
GO
ALTER TABLE [dbo].[PUBLICACION] CHECK CONSTRAINT [CK_Cantidad_Comentarios]
GO
ALTER TABLE [dbo].[PUBLICACION]  WITH CHECK ADD  CONSTRAINT [CK_Has_Image] CHECK  (([TIENE_IMAGEN]=(0) AND [IMAGEN] IS NULL OR [TIENE_IMAGEN]=(1) AND [IMAGEN] IS NOT NULL))
GO
ALTER TABLE [dbo].[PUBLICACION] CHECK CONSTRAINT [CK_Has_Image]
GO
ALTER TABLE [dbo].[PUBLICACION]  WITH CHECK ADD  CONSTRAINT [CK_Publicacion_Imagen_Encuesta_Texto] CHECK  (([TIENE_IMAGEN]=(1) OR [TIENE_ENCUESTA]=(1) OR [TEXTO] IS NOT NULL))
GO
ALTER TABLE [dbo].[PUBLICACION] CHECK CONSTRAINT [CK_Publicacion_Imagen_Encuesta_Texto]
GO

CREATE TABLE [dbo].[PREMIO](
	[ID_PREMIO] [int] NOT NULL,
	[NOMBRE] [varchar](50) NOT NULL,
	[DESCRIPCION] [varchar](250) NOT NULL,
 CONSTRAINT [PREMIO_PK] PRIMARY KEY CLUSTERED 
(
	[ID_PREMIO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[PAIS](
	[ID_PAIS] [int] NOT NULL,
	[NOMBRE] [varchar](100) NOT NULL,
	[ID_REGION] [int] NOT NULL,
 CONSTRAINT [PAIS_PK] PRIMARY KEY CLUSTERED 
(
	[ID_PAIS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[PAIS]  WITH CHECK ADD  CONSTRAINT [PAIS_REGION_FK] FOREIGN KEY([ID_REGION])
REFERENCES [dbo].[REGION] ([ID_REGION])
GO

ALTER TABLE [dbo].[PAIS] CHECK CONSTRAINT [PAIS_REGION_FK]
GO


CREATE TABLE [dbo].[VOTO](
	[ID_VOTO] [int] NOT NULL,
	[ID_USUARIO] [int] NOT NULL,
	[ID_PUBLICACION] [int] NULL,
	[ID_COMENTARIO] [int] NULL,
	[TIPO] [bit] NOT NULL,
	[FECHA_HORA_ALTA] [datetime] NOT NULL,
	[FECHA_HORA_BAJA] [datetime] NULL,
 CONSTRAINT [VOTO_PK] PRIMARY KEY CLUSTERED 
(
	[ID_VOTO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[VOTO]  WITH CHECK ADD  CONSTRAINT [VOTO_COMENTARIO_FK] FOREIGN KEY([ID_COMENTARIO])
REFERENCES [dbo].[COMENTARIO] ([ID_COMENTARIO])
GO

ALTER TABLE [dbo].[VOTO] CHECK CONSTRAINT [VOTO_COMENTARIO_FK]
GO

ALTER TABLE [dbo].[VOTO]  WITH CHECK ADD  CONSTRAINT [VOTO_PUBLICACION_FK] FOREIGN KEY([ID_PUBLICACION])
REFERENCES [dbo].[PUBLICACION] ([ID_PUBLICACION])
GO

ALTER TABLE [dbo].[VOTO] CHECK CONSTRAINT [VOTO_PUBLICACION_FK]
GO

ALTER TABLE [dbo].[VOTO]  WITH CHECK ADD  CONSTRAINT [VOTO_USUARIO_FK] FOREIGN KEY([ID_USUARIO])
REFERENCES [dbo].[USUARIO] ([ID_USUARIO])
GO

ALTER TABLE [dbo].[VOTO] CHECK CONSTRAINT [VOTO_USUARIO_FK]
GO

ALTER TABLE [dbo].[VOTO]  WITH CHECK ADD  CONSTRAINT [CK_Arc_Voto] CHECK  (([ID_PUBLICACION] IS NOT NULL AND [ID_COMENTARIO] IS NULL OR [ID_PUBLICACION] IS NULL AND [ID_COMENTARIO] IS NOT NULL))
GO

ALTER TABLE [dbo].[VOTO] CHECK CONSTRAINT [CK_Arc_Voto]
GO

CREATE TABLE [dbo].[USUARIO_POR_SUBREDDIT](
	[ID_USUARIO] [int] NOT NULL,
	[FECHA_HORA_BAJA] [datetime] NULL,
	[ID_SUBREDDIT] [int] NOT NULL,
	[FECHA_HORA_ALTA] [datetime] NOT NULL,
 CONSTRAINT [USUARIO_POR_SUBREDDIT_PK] PRIMARY KEY CLUSTERED 
(
	[ID_USUARIO] ASC,
	[ID_SUBREDDIT] ASC,
	[FECHA_HORA_ALTA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[USUARIO_POR_SUBREDDIT]  WITH CHECK ADD  CONSTRAINT [USUARIO_POR_SUBREDDIT_SUBREDDIT_FK] FOREIGN KEY([ID_SUBREDDIT])
REFERENCES [dbo].[SUBREDDIT] ([ID_SUBREDDIT])
GO

ALTER TABLE [dbo].[USUARIO_POR_SUBREDDIT] CHECK CONSTRAINT [USUARIO_POR_SUBREDDIT_SUBREDDIT_FK]
GO

ALTER TABLE [dbo].[USUARIO_POR_SUBREDDIT]  WITH CHECK ADD  CONSTRAINT [USUARIO_POR_SUBREDDIT_USUARIO_FK] FOREIGN KEY([ID_USUARIO])
REFERENCES [dbo].[USUARIO] ([ID_USUARIO])
GO

ALTER TABLE [dbo].[USUARIO_POR_SUBREDDIT] CHECK CONSTRAINT [USUARIO_POR_SUBREDDIT_USUARIO_FK]
GO

CREATE TABLE [dbo].[SUBREDDIT](
	[ID_SUBREDDIT] [int] NOT NULL,
	[NOMBRE] [varchar](100) NOT NULL,
	[DESCRIPCION] [varchar](250) NOT NULL,
	[FECHA_HORA_ALTA] [datetime] NOT NULL,
	[CANTIDAD_MIEMBROS] [int] NOT NULL,
	[FECHA_HORA_BAJA] [datetime] NULL,
 CONSTRAINT [SUBREDDIT_PK] PRIMARY KEY CLUSTERED 
(
	[ID_SUBREDDIT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SUBREDDIT]  WITH CHECK ADD  CONSTRAINT [CK_Cantidad_Miembros] CHECK  (([CANTIDAD_MIEMBROS]>=(0)))
GO

ALTER TABLE [dbo].[SUBREDDIT] CHECK CONSTRAINT [CK_Cantidad_Miembros]
GO

ALTER TABLE [dbo].[SUBREDDIT]  WITH CHECK ADD  CONSTRAINT [CK_Fecha_Subreddit] CHECK  (([FECHA_HORA_ALTA]<[FECHA_HORA_BAJA]))
GO

ALTER TABLE [dbo].[SUBREDDIT] CHECK CONSTRAINT [CK_Fecha_Subreddit]
GO

CREATE TABLE [dbo].[SEXO](
	[ID_SEXO] [int] NOT NULL,
	[DESCRIPCION] [varchar](30) NOT NULL,
 CONSTRAINT [SEXO_PK] PRIMARY KEY CLUSTERED 
(
	[ID_SEXO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[REGION](
	[ID_REGION] [int] NOT NULL,
	[HABITANTES] [int] NOT NULL,
	[NOMBRE] [varchar](100) NOT NULL,
 CONSTRAINT [REGION_PK] PRIMARY KEY CLUSTERED 
(
	[ID_REGION] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[COMENTARIO](
	[ID_COMENTARIO] [int] NOT NULL,
	[ID_USUARIO] [int] NOT NULL,
	[ID_PUBLICACION] [int] NOT NULL,
	[FECHA_HORA_ALTA] [datetime] NOT NULL,
	[TIENE_IMAGEN] [bit] NOT NULL,
	[TEXTO] [varchar](8000) NULL,
	[IMAGEN] [varchar](100) NULL,
	[ID_COMENTARIO_PADRE] [int] NULL,
	[FECHA_HORA_BAJA] [datetime] NULL,
 CONSTRAINT [COMENTARIO_PK] PRIMARY KEY CLUSTERED 
(
	[ID_COMENTARIO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[COMENTARIO]  WITH CHECK ADD  CONSTRAINT [COMENTARIO_COMENTARIO_FK] FOREIGN KEY([ID_COMENTARIO_PADRE])
REFERENCES [dbo].[COMENTARIO] ([ID_COMENTARIO])
GO

ALTER TABLE [dbo].[COMENTARIO] CHECK CONSTRAINT [COMENTARIO_COMENTARIO_FK]
GO

ALTER TABLE [dbo].[COMENTARIO]  WITH CHECK ADD  CONSTRAINT [COMENTARIO_PUBLICACION_FK] FOREIGN KEY([ID_PUBLICACION])
REFERENCES [dbo].[PUBLICACION] ([ID_PUBLICACION])
GO

ALTER TABLE [dbo].[COMENTARIO] CHECK CONSTRAINT [COMENTARIO_PUBLICACION_FK]
GO

ALTER TABLE [dbo].[COMENTARIO]  WITH CHECK ADD  CONSTRAINT [COMENTARIO_USUARIO_FK] FOREIGN KEY([ID_USUARIO])
REFERENCES [dbo].[USUARIO] ([ID_USUARIO])
GO

ALTER TABLE [dbo].[COMENTARIO] CHECK CONSTRAINT [COMENTARIO_USUARIO_FK]
GO

CREATE TABLE [dbo].[SUBREDDIT_POR_TOPICO](
	[ID_SUBREDDIT] [int] NOT NULL,
	[ID_TOPICO] [int] NOT NULL,
	[FECHA_HORA_ALTA] [datetime] NOT NULL,
	[ES_PRINCIPAL] [bit] NOT NULL,
	[FECHA_HORA_BAJA] [datetime] NULL,
 CONSTRAINT [SUBREDDIT_POR_TOPICO_PK] PRIMARY KEY CLUSTERED 
(
	[ID_SUBREDDIT] ASC,
	[ID_TOPICO] ASC,
	[FECHA_HORA_ALTA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SUBREDDIT_POR_TOPICO]  WITH CHECK ADD  CONSTRAINT [SUBREDDIT_POR_TOPICO_SUBREDDIT_FK] FOREIGN KEY([ID_SUBREDDIT])
REFERENCES [dbo].[SUBREDDIT] ([ID_SUBREDDIT])
GO

ALTER TABLE [dbo].[SUBREDDIT_POR_TOPICO] CHECK CONSTRAINT [SUBREDDIT_POR_TOPICO_SUBREDDIT_FK]
GO

ALTER TABLE [dbo].[SUBREDDIT_POR_TOPICO]  WITH CHECK ADD  CONSTRAINT [SUBREDDIT_POR_TOPICO_TOPICO_FK] FOREIGN KEY([ID_TOPICO])
REFERENCES [dbo].[TOPICO] ([ID_TOPICO])
GO

ALTER TABLE [dbo].[SUBREDDIT_POR_TOPICO] CHECK CONSTRAINT [SUBREDDIT_POR_TOPICO_TOPICO_FK]
GO

CREATE TABLE [dbo].[TOPICO](
	[ID_TOPICO] [int] NOT NULL,
	[NOMBRE] [varchar](50) NOT NULL,
	[DESCRIPCION] [varchar](250) NOT NULL,
	[FECHA_HORA_ALTA] [datetime] NOT NULL,
	[FECHA_HORA_BAJA] [datetime] NULL,
 CONSTRAINT [TOPICO_PK] PRIMARY KEY CLUSTERED 
(
	[ID_TOPICO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[TOPICO_POR_USUARIO](
	[ID_TOPICO] [int] NOT NULL,
	[ID_USUARIO] [int] NOT NULL,
	[FECHA_HORA_ALTA] [datetime] NOT NULL,
	[FECHA_HORA_BAJA] [datetime] NULL,
 CONSTRAINT [TOPICO_POR_USUARIO_PK] PRIMARY KEY CLUSTERED 
(
	[ID_TOPICO] ASC,
	[ID_USUARIO] ASC,
	[FECHA_HORA_ALTA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TOPICO_POR_USUARIO]  WITH CHECK ADD  CONSTRAINT [TOPICO_POR_USUARIO_TOPICO_FK] FOREIGN KEY([ID_TOPICO])
REFERENCES [dbo].[TOPICO] ([ID_TOPICO])
GO

ALTER TABLE [dbo].[TOPICO_POR_USUARIO] CHECK CONSTRAINT [TOPICO_POR_USUARIO_TOPICO_FK]
GO

ALTER TABLE [dbo].[TOPICO_POR_USUARIO]  WITH CHECK ADD  CONSTRAINT [TOPICO_POR_USUARIO_USUARIO_FK] FOREIGN KEY([ID_USUARIO])
REFERENCES [dbo].[USUARIO] ([ID_USUARIO])
GO

ALTER TABLE [dbo].[TOPICO_POR_USUARIO] CHECK CONSTRAINT [TOPICO_POR_USUARIO_USUARIO_FK]
GO

CREATE TABLE [dbo].[USUARIO](
	[ID_USUARIO] [int] NOT NULL,
	[NOMBRE] [varchar](75) NOT NULL,
	[FECHA_NACIMIENTO] [date] NOT NULL,
	[FECHA_HORA_ALTA] [datetime] NOT NULL,
	[FECHA_HORA_BAJA] [datetime] NULL,
	[ID_PAIS] [int] NOT NULL,
	[ID_SEXO] [int] NOT NULL,
	[ID_RANGO_ETARIO] [int] NOT NULL,
	[EMAIL] [varchar](100) NOT NULL,
 CONSTRAINT [USUARIO_PK] PRIMARY KEY CLUSTERED 
(
	[ID_USUARIO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[USUARIO]  WITH CHECK ADD  CONSTRAINT [USUARIO_PAIS_FK] FOREIGN KEY([ID_PAIS])
REFERENCES [dbo].[PAIS] ([ID_PAIS])
GO

ALTER TABLE [dbo].[USUARIO] CHECK CONSTRAINT [USUARIO_PAIS_FK]
GO

ALTER TABLE [dbo].[USUARIO]  WITH CHECK ADD  CONSTRAINT [USUARIO_RANGO_ETARIO_FK] FOREIGN KEY([ID_RANGO_ETARIO])
REFERENCES [dbo].[RANGO_ETARIO] ([ID_RANGO_ETARIO])
GO

ALTER TABLE [dbo].[USUARIO] CHECK CONSTRAINT [USUARIO_RANGO_ETARIO_FK]
GO

ALTER TABLE [dbo].[USUARIO]  WITH CHECK ADD  CONSTRAINT [USUARIO_SEXO_FK] FOREIGN KEY([ID_SEXO])
REFERENCES [dbo].[SEXO] ([ID_SEXO])
GO

ALTER TABLE [dbo].[USUARIO] CHECK CONSTRAINT [USUARIO_SEXO_FK]
GO

ALTER TABLE [dbo].[USUARIO]  WITH CHECK ADD  CONSTRAINT [CK_EMAIL] CHECK  (([EMAIL] like '%@%.%' AND NOT [EMAIL] like '%@%@%' AND NOT [EMAIL] like '%..%'))
GO

ALTER TABLE [dbo].[USUARIO] CHECK CONSTRAINT [CK_EMAIL]
GO

ALTER TABLE [dbo].[USUARIO]  WITH CHECK ADD  CONSTRAINT [CK_fecha_1] CHECK  (([FECHA_HORA_BAJA]>[FECHA_HORA_ALTA] OR [FECHA_HORA_BAJA] IS NULL))
GO

ALTER TABLE [dbo].[USUARIO] CHECK CONSTRAINT [CK_fecha_1]
GO

ALTER TABLE [dbo].[USUARIO]  WITH CHECK ADD  CONSTRAINT [CK_Usuario_Mayor_de_Edad] CHECK  ((datediff(month,[FECHA_NACIMIENTO],getdate())>=(216)))
GO

ALTER TABLE [dbo].[USUARIO] CHECK CONSTRAINT [CK_Usuario_Mayor_de_Edad]
GO

CREATE TABLE [dbo].[PREMIO_POR_USUARIO](
	[ID_USUARIO_OTORGA] [int] NOT NULL,
	[ID_USUARIO_RECIBE] [int] NOT NULL,
	[ID_PREMIO] [int] NOT NULL,
	[FECHA_HORA_ALTA] [datetime] NOT NULL,
	[ID_PUBLICACION] [int] NULL,
	[ID_COMENTARIO] [int] NULL,
 CONSTRAINT [PREMIO_POR_USUARIO_PK] PRIMARY KEY CLUSTERED 
(
	[ID_USUARIO_OTORGA] ASC,
	[ID_USUARIO_RECIBE] ASC,
	[ID_PREMIO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PREMIO_POR_USUARIO]  WITH CHECK ADD  CONSTRAINT [PREMIO_POR_USUARIO_COMENTARIO_FK] FOREIGN KEY([ID_COMENTARIO])
REFERENCES [dbo].[COMENTARIO] ([ID_COMENTARIO])
GO
ALTER TABLE [dbo].[PREMIO_POR_USUARIO] CHECK CONSTRAINT [PREMIO_POR_USUARIO_COMENTARIO_FK]
GO
ALTER TABLE [dbo].[PREMIO_POR_USUARIO]  WITH CHECK ADD  CONSTRAINT [PREMIO_POR_USUARIO_PREMIO_FK] FOREIGN KEY([ID_PREMIO])
REFERENCES [dbo].[PREMIO] ([ID_PREMIO])
GO
ALTER TABLE [dbo].[PREMIO_POR_USUARIO] CHECK CONSTRAINT [PREMIO_POR_USUARIO_PREMIO_FK]
GO
ALTER TABLE [dbo].[PREMIO_POR_USUARIO]  WITH CHECK ADD  CONSTRAINT [PREMIO_POR_USUARIO_PUBLICACION_FK] FOREIGN KEY([ID_PUBLICACION])
REFERENCES [dbo].[PUBLICACION] ([ID_PUBLICACION])
GO
ALTER TABLE [dbo].[PREMIO_POR_USUARIO] CHECK CONSTRAINT [PREMIO_POR_USUARIO_PUBLICACION_FK]
GO
ALTER TABLE [dbo].[PREMIO_POR_USUARIO]  WITH CHECK ADD  CONSTRAINT [PREMIO_POR_USUARIO_USUARIO_FK] FOREIGN KEY([ID_USUARIO_OTORGA])
REFERENCES [dbo].[USUARIO] ([ID_USUARIO])
GO
ALTER TABLE [dbo].[PREMIO_POR_USUARIO] CHECK CONSTRAINT [PREMIO_POR_USUARIO_USUARIO_FK]
GO
ALTER TABLE [dbo].[PREMIO_POR_USUARIO]  WITH CHECK ADD  CONSTRAINT [PREMIO_POR_USUARIO_USUARIO_FK1] FOREIGN KEY([ID_USUARIO_RECIBE])
REFERENCES [dbo].[USUARIO] ([ID_USUARIO])
GO
ALTER TABLE [dbo].[PREMIO_POR_USUARIO] CHECK CONSTRAINT [PREMIO_POR_USUARIO_USUARIO_FK1]
GO