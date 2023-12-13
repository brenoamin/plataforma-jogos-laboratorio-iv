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
	🚧 Modulo Background 🚧
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

O módulo Background tem a função de controlar a exibição de um fundo em um sistema gráfico. Ele recebe sinais que indicam a posição da imagem de fundo (row e col) e os canais RGB correspondentes dessa imagem (r_in, g_in, e b_in). Ele também possui sinais de saída para os canais RGB que são usados para exibir a imagem de fundo (r_out, g_out, e b_out), bem como sinais de saída para a posição atual da imagem (x_out e y_out).

O módulo de exibição,"VGA_Interface", é uma parte essencial do projeto Merge. Este módulo é responsável por gerenciar a interface VGA para exibição dos resultados gerados pelo módulo Merge.

---

## ⚙️ Funcionamento

O módulo Background  funciona da seguinte maneira

O módulo mantém um estado interno (current_row e current_col) para acompanhar a posição atual da imagem de fundo.
Quando um sinal PUT_IMAGE é recebido, o módulo atualiza a posição da imagem de fundo.
Os sinais RGB de saída são atualizados de acordo com os canais RGB de entrada.
Os sinais de saída x_out e y_out indicam a posição atual da imagem de fundo.

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