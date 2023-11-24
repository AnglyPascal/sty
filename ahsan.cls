\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ahsan}[2023/11/23 LaTeX Master Class]

\RequirePackage{kvoptions}

\newif \if@ahsan@article@is
\newif \if@ahsan@beamer@is
\newif \if@ahsan@memoir@is

%%% Default is article
\def\ahsan@class@name{article}
\@ahsan@article@istrue

\DeclareVoidOption{article}{}
\DeclareVoidOption{beamer}{
    \@ahsan@article@isfalse
    \@ahsan@beamer@istrue
    \renewcommand\ahsan@class@name{beamer}
    \PassOptionsToClass{notheorems}{beamer}
}
\DeclareVoidOption{memoir}{
    \@ahsan@article@isfalse
    \@ahsan@memoir@istrue
    \renewcommand\ahsan@class@name{memoir}
}

\def\ahsan@fonts@en{yes}
\DeclareVoidOption{no fonts}{\renewcommand\ahsan@fonts@en{no}}
\def\ahsan@font@shape{serif}
\DeclareVoidOption{sans}{\renewcommand\ahsan@font@shape{sans}}
\DeclareVoidOption{mono}{\renewcommand\ahsan@font@shape{mono}}

\def\ahsan@font@size{10pt}
\DeclareVoidOption{10pt}{\renewcommand\ahsan@font@size{10pt}}
\DeclareVoidOption{11pt}{\renewcommand\ahsan@font@size{11pt}}
\DeclareVoidOption{12pt}{\renewcommand\ahsan@font@size{12pt}}

%%% Page size
\def\ahsan@page@size{a4paper}

%%% Index: disabled by default
\newif\if@ahsan@index@is
\@ahsan@index@isfalse
\DeclareVoidOption{index}{\@ahsan@index@istrue}

%%% Theme
\DeclareStringOption[mono]{theme}

%%% Theorems
\DeclareStringOption[minimal]{theorems}

%%% header and footer
\DeclareStringOption[none]{hdr}

%%% figures and tikz
\DeclareStringOption[full]{figures}

%%% toc 
\DeclareStringOption[en]{toc}

%%% bibliography 
\DeclareStringOption[]{ref}

%%% Code listing: enabled by default
\newif\if@ahsan@code@is
\@ahsan@code@istrue
\DeclareVoidOption{no code}{\@ahsan@code@isfalse}


%%% Send the rest of options to the class
\DeclareDefaultOption{
    \expandafter\PassOptionsToPackage
    \expandafter{\CurrentOption}{\ahsan@class@name}
}

\ProcessKeyvalOptions* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\if@ahsan@beamer@is  \PassOptionsToClass{aspectratio=169}{beamer} \fi

%%% Load the class
\LoadClass[\ahsan@font@size, \ahsan@page@size]{\ahsan@class@name}


%%% Load class specific configs
\if@ahsan@article@is \RequirePackage{_article} \fi
\if@ahsan@memoir@is  \RequirePackage{_memoir} \fi
\if@ahsan@beamer@is  \RequirePackage[\ahsan@theme]{_beamer} \fi


%%% load fonts style
\RequirePackage[
    \ahsan@fonts@en,
    \ahsan@font@shape, 
    \ahsan@class@name
]{_fonts}


%%% load maths packages
\RequirePackage[]{_maths}

%%% Load theme
\RequirePackage[\ahsan@theme]{_theme}

%%% Load theorems
\RequirePackage[\ahsan@theorems]{_theorems}

%%% Load headers and footers
\RequirePackage[\ahsan@hdr]{_header_footer}

%%% Load figures
\RequirePackage[\ahsan@figures]{_figures}

%%% Load toc settings
\RequirePackage[\ahsan@toc, \ahsan@class@name]{_toc}

%%% Load reference settings
\RequirePackage[\ahsan@ref]{_ref}

%%% add signature and author name
\RequirePackage[]{_sig}

%%% setup index
\if@ahsan@index@is
    \RequirePackage[]{_index}
    \RequirePackage[]{_thm_w_index}
\fi

%%% Load code style
\if@ahsan@code@is
    \RequirePackage[]{_code}
\fi

\if@ahsan@beamer@is
\else
    \RequirePackage[]{_enum}
\fi