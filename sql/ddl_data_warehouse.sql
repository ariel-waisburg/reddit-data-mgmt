-- BT_PUBLICACION --

CREATE TABLE [dbo].[BT_PUBLICACION](
    [ID_PUBLICACION] [int] NOT NULL,
    [ID_USUARIO] [int] NOT NULL,
    [ID_SUBREDDIT] [int] NOT NULL,
    [ID_FECHA] [datetime] NOT NULL,
    [ID_RANGO_ETARIO] [int] NOT NULL,
    [ID_HORA] [time](7) NOT NULL,
    [CANTIDAD_COMENTARIOS] [int] NULL,
    [CANTIDAD_UPVOTES] [int] NULL,
    [CANTIDAD_DOWNVOTES] [int] NULL,
    [CANTIDAD_PREMIOS] [int] NULL,
    [CANTIDAD_TOPICOS] [int] NULL,
    PRIMARY KEY CLUSTERED ([ID_PUBLICACION] ASC)
) ON [PRIMARY]

-- LU_ANIO --

CREATE TABLE [dbo].[LU_ANIO](
    [ID_ANIO] [int] NOT NULL,
    [DESCRIPCION] [char](4) NULL
) ON [PRIMARY]

-- LU_DIA --

CREATE TABLE [dbo].[LU_DIA](
    [ID_DIA] [date] NOT NULL,
    [DESCRIPCION] [char](11) NOT NULL,
    [ID_MES] [int] NOT NULL
) ON [PRIMARY]

-- LU_HORA --

CREATE TABLE [dbo].[LU_HORA](
    [ID_HORA] [time](7) NOT NULL,
    [DESCRIPCION] [varchar](20) NOT NULL,
    [ID_RANGO_HORARIO] [int] NOT NULL
) ON [PRIMARY]

-- LU_MES --

CREATE TABLE [dbo].[LU_MES](
    [ID_MES] [int] NOT NULL,
    [DESCRIPCION] [varchar](20) NOT NULL,
    [ID_TRIMESTRE] [int] NOT NULL
) ON [PRIMARY]

-- LU_PAIS --

CREATE TABLE [dbo].[LU_PAIS](
    [ID_PAIS] [int] NOT NULL,
    [NOMBRE] [char](100) NOT NULL,
    [ID_REGION] [int] NOT NULL,
    PRIMARY KEY CLUSTERED ([ID_PAIS] ASC)
) ON [PRIMARY]

-- LU_RANGO_ETARIO --

CREATE TABLE [dbo].[LU_RANGO_ETARIO](
    [ID_RANGO_ETARIO] [int] NOT NULL,
    [NOMBRE] [char](30) NULL,
    PRIMARY KEY CLUSTERED ([ID_RANGO_ETARIO] ASC)
) ON [PRIMARY]

-- LU_RANGO_HORARIO --

CREATE TABLE [dbo].[LU_RANGO_HORARIO](
    [ID_RANGO_HORARIO] [int] NOT NULL,
    [DESCRIPCION] [varchar](30) NOT NULL
) ON [PRIMARY]

-- LU_REGION --

CREATE TABLE [dbo].[LU_REGION](
    [ID_REGION] [int] NOT NULL,
    [NOMBRE] [char](100) NULL,
    PRIMARY KEY CLUSTERED ([ID_REGION] ASC)
) ON [PRIMARY]

-- LU_SEXO --

CREATE TABLE [dbo].[LU_SEXO](
    [ID_SEXO] [int] NOT NULL,
    [DESCRIPCION] [char](30) NOT NULL,
    PRIMARY KEY CLUSTERED ([ID_SEXO] ASC)
) ON [PRIMARY]

-- LU_SUBREDDIT --

CREATE TABLE [dbo].[LU_SUBREDDIT](
    [ID_SUBREDDIT] [int] NOT NULL,
    [NOMBRE] [char](100) NULL,
    PRIMARY KEY CLUSTERED ([ID_SUBREDDIT] ASC)
) ON [PRIMARY]

-- LU_TRIMESTRE --

CREATE TABLE [dbo].[LU_TRIMESTRE](
    [ID_TRIMESTRE] [int] NOT NULL,
    [DESCRIPCION] [varchar](15) NOT NULL,
    [ID_ANIO] [int] NOT NULL
) ON [PRIMARY]

-- LU_USUARIO --

CREATE TABLE [dbo].[LU_USUARIO](
    [ID_USUARIO] [int] NOT NULL,
    [ID_SEXO] [int] NOT NULL,
    [ID_PAIS] [int] NOT NULL,
    PRIMARY KEY CLUSTERED ([ID_USUARIO] ASC)
) ON [PRIMARY]
