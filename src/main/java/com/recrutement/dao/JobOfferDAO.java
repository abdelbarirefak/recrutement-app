package com.recrutement.dao;

import com.recrutement.entity.JobOffer;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.util.List;

public class JobOfferDAO {

    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("recrutementPU");

    public void save(JobOffer offer) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(offer);
            em.getTransaction().commit();
        } finally { em.close(); }
    }

    public List<JobOffer> findAll() {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery("SELECT j FROM JobOffer j", JobOffer.class).getResultList();
        } finally { em.close(); }
    }
    
    // NOUVELLE MÉTHODE : SUPPRIMER UNE OFFRE
    public void delete(long id) {
        EntityManager em = emf.createEntityManager(); // Assurez-vous d'avoir 'emf' défini en haut de la classe
        try {
            em.getTransaction().begin();
            JobOffer offer = em.find(JobOffer.class, id);
            if (offer != null) {
                em.remove(offer);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
}