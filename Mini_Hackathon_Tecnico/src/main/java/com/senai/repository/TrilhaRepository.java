package com.senai.repository;

import com.senai.model.Trilha;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

public class TrilhaRepository {

    public List<Trilha> carregarTrilhas() {
        List<Trilha> trilhas = new ArrayList<>();

        try (InputStream is = Thread.currentThread().getContextClassLoader().getResourceAsStream("trilhas.txt")) {
            if (is == null) {
                System.err.println("Erro: Arquivo trilhas.txt não encontrado em src/main/resources!");
                return trilhas;
            }

            try (BufferedReader reader = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))) {
                String linha;
                while ((linha = reader.readLine()) != null) {
                    if (linha.trim().isEmpty()) continue;

                    String[] partes = linha.split(";");
                    if (partes.length >= 3) {
                        int id = Integer.parseInt(partes[0].trim());
                        String nome = partes[1].trim();
                        String descricao = partes[2].trim();

                        trilhas.add(new Trilha(id, nome, descricao));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return trilhas;
    }
}
