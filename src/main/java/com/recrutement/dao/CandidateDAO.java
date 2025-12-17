package com.recrutement.dao;

import com.recrutement.entity.Candidate;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.util.List;

public class CandidateDAO {

    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("recrutementPU");

    public void save(Candidate candidate) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            
            // Vérifier si le candidat existe déjà pour cet utilisateur
            try {
                Candidate existing = em.createQuery("SELECT c FROM Candidate c WHERE c.user.id = :uid", Candidate.class)
                                       .setParameter("uid", candidate.getUser().getId())
                                       .getSingleResult();
                
                // Si trouvé, on met à jour l'ID pour que 'merge' fonctionne
                candidate.setId(existing.getId());
                em.merge(candidate); // Mise à jour
            } catch (Exception e) {
                // Si pas trouvé, on crée
                em.persist(candidate); // Création
            }
            
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public Candidate findById(Long id) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(Candidate.class, id);
        } finally {
            em.close();
        }
    }
    
    // Bonus: Find all candidates (useful for a recruiter seeing a list)
    public List<Candidate> findAll() {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery("SELECT c FROM Candidate c", Candidate.class).getResultList();
        } finally {
            em.close();
        }
    }
}