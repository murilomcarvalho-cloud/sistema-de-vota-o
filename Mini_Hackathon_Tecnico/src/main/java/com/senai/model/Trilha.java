package com.senai.model;

public class Trilha {
    private int id;
    private String nome;
    private String descricao;
    private int votos;

    public Trilha(int id, String nome, String descricao) {
        this.id = id;
        this.nome = nome;
        this.descricao = descricao;
        this.votos = 0;
    }

    public int getId() { return id; }
    public String getNome() { return nome; }
    public String getDescricao() { return descricao; }
    public int getVotos() { return votos; }

    public void incrementarVoto() {
        this.votos++;
    }
}
