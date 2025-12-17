package com.recrutement.dao;

import com.recrutement.entity.Application;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.util.List;

public class ApplicationDAO {
    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("recrutementPU");

    public List<Application> findAll() {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery("SELECT a FROM Application a", Application.class).getResultList();
        } finally {
            em.close();
        }
    }
}