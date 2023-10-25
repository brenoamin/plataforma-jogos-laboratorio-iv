# Modulo de Exibição e ImageMerge - Sobreposição de Imagens em Verilog

<p align="center">
  <img alt="GitHub language count" src="https://img.shields.io/github/languages/count/brenoamin/plataforma-jogos-laboratorio-iv?color=%2304D361">
  <img alt="Repository size" src="https://img.shields.io/github/repo-size/brenoamin/plataforma-jogos-laboratorio-iv">
  <a href="https://github.com/brenoamin/plataforma-jogos-laboratorio-iv/commits/main">
    <img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/brenoamin/plataforma-jogos-laboratorio-iv">
  </a>
  <a href="https://github.com/seu-usuario/seu-repositorio/stargazers">
    <img alt="Stargazers" src="https://img.shields.io/github/stars/seu-usuario/seu-repositorio?style=social">
  </a>
</p>

<h4 align="center"> 
	🚧 ImageMerge 🚧
</h4>

<p align="center">
	<img alt="Status Em Andamento" src="https://img.shields.io/badge/STATUS-EM%20ANDAMENTO-yellow">
</p>

<p align="center">
 <a href="#-sobre-o-projeto">Sobre</a> •
 <a href="#-funcionamento">Funcionamento</a> •
 <a href="#-como-executar-o-projeto">Como executar</a> • 
 <a href="#-tecnologias">Tecnologias</a>• 
</p>

## 💻 Sobre o projeto

Projeto ImageMerge implementa um módulo Verilog chamado ImageMerge, que permite sobrepor imagens a partir de uma SDRAM e de um módulo de sprites com controle de opacidade (canal alfa). Essa funcionalidade é útil para criar efeitos visuais e sobreposições de imagens em sistemas de exibição.

O módulo de exibição,"VGA_Interface", é uma parte essencial do projeto ImageMerge. Este módulo é responsável por gerenciar a interface VGA para exibição dos resultados gerados pelo módulo ImageMerge.

---

## ⚙️ Funcionamento

O módulo ImageMerge opera de acordo com a fórmula a seguir:

```verilog
merged_R = (alpha * sprite_R + (255 - alpha) * sdram_R) / 255;
merged_G = (alpha * sprite_G + (255 - alpha) * sdram_G) / 255;
merged_B = (alpha * sprite_B + (255 - alpha) * sdram_B) / 255;
Isso permite que as cores do sprite e da SDRAM sejam combinadas com base no valor de alfa, controlando assim a opacidade da imagem resultante.

🖥️ Módulo VGA_Interface
Além do módulo ImageMerge, o projeto inclui o módulo VGA_Interface, que é responsável por controlar a interface VGA para exibição dos resultados. Ele gerencia a sincronização horizontal e vertical, geração de cores e posicionamento na tela.


---

## 🛣️ Como executar o projeto

```bash

Para usar o módulo ImageMerge em seu projeto Verilog, siga as instruções abaixo:

Clone este repositório.

Instancie o módulo ImageMerge em seu projeto Verilog conforme necessário.

Certifique-se de que as entradas e saídas do módulo ImageMerge estejam conectadas corretamente ao seu projeto.

Compile e execute seu projeto para ver a sobreposição de imagens em ação.

```


## 🛠 Tecnologias

* #Verilog

---