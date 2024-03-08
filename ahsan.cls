\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ahsan}[2023/11/23 LaTeX Master Class]

\RequirePackage{kvoptions}

\newif \if@ahsan@article@is
\newif \if@ahsan@beamer@is
\newif \if@ahsan@memoir@is

\newif \if@ahsan@oxford@is \@ahsan@oxford@isfalse

%%% Default is article
\def\ahsan@class@name{article}
\@ahsan@article@istrue

\DeclareVoidOption{article}{}
\DeclareVoidOption{report}{
    \renewcommand\ahsan@class@name{report}
}
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

\DeclareVoidOption{oxford}{\@ahsan@oxford@istrue}

\DeclareStringOption[169]{aspectratio}

\def\ahsan@fonts@en{yes}
\DeclareVoidOption{no fonts}{\renewcommand\ahsan@fonts@en{no}}
\def\ahsan@font@shape{serif}
\DeclareVoidOption{sans}{\renewcommand\ahsan@font@shape{sans}}
\DeclareVoidOption{mono}{\renewcommand\ahsan@font@shape{mono}}

\def\ahsan@font@size{11pt}
\DeclareVoidOption{10pt}{\renewcommand\ahsan@font@size{10pt}}
\DeclareVoidOption{11pt}{\renewcommand\ahsan@font@size{11pt}}
\DeclareVoidOption{12pt}{\renewcommand\ahsan@font@size{12pt}}

\DeclareVoidOption{kindle}{
    \PassOptionsToPackage{kindle}{_article}
    \renewcommand\ahsan@font@size{10pt}
}

%%% Page size
\def\ahsan@page@size{a4paper}

%%% Index: disabled by default
\newif\if@ahsan@index@is
\@ahsan@index@isfalse
\DeclareVoidOption{index}{\@ahsan@index@istrue}

\DeclareVoidOption{glossary}{
    \PassOptionsToPackage{glossary}{_index}
}

%%% Theme
\DeclareStringOption[mono]{theme}

%%% Theorems
\DeclareStringOption[]{theorems}

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

\if@ahsan@beamer@is  \PassOptionsToClass{aspectratio=\ahsan@aspectratio}{beamer} \fi

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

%%% setup index
\if@ahsan@index@is
    \RequirePackage[\ahsan@class@name]{_index}
\fi

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

%%% Load code style
\if@ahsan@code@is
    \RequirePackage[]{_code}
\fi

\if@ahsan@beamer@is
\else
    \RequirePackage[]{_enum}
\fi

%%% Load oxford specific commands
\if@ahsan@oxford@is
    \usepackage{_oxford}
\fi


%%% suppress harmless warnings
%
% overfull 
\hfuzz=100pt 
% math shift error from hyperref
% https://tex.stackexchange.com/questions/537449/removing-math-shift
\pdfstringdefDisableCommands{\let\HyPsd@CatcodeWarning\@gobble}
% all hyperref warnings
% https://tex.stackexchange.com/questions/415625/avoiding-hyperref-warning-ignoring-empty-anchor
\def\Hy@Warning#1{}
% underfull badness
\hbadness = 10000

%%% package for any testing
\usepackage{_tests}

