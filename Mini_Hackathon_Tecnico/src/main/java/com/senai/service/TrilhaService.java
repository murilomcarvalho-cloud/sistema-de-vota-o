package com.senai.service;

import com.senai.model.Trilha;
import com.senai.repository.TrilhaRepository;
import java.util.List;

public class TrilhaService {
    private static TrilhaService instance;
    private final List<Trilha> trilhas;

    private TrilhaService() {
        TrilhaRepository repo = new TrilhaRepository();
        this.trilhas = repo.carregarTrilhas();
    }

    public static synchronized TrilhaService getInstance() {
        if (instance == null) {
            instance = new TrilhaService();
        }
        return instance;
    }

    public List<Trilha> getTrilhas() {
        return this.trilhas;
    }

    public synchronized boolean registrarVoto(int id) {
        for (Trilha t : trilhas) {
            if (t.getId() == id) {
                t.incrementarVoto();
                return true;
            }
        }
        return false;
    }
}
