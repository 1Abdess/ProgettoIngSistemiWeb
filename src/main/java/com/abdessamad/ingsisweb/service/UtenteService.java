package com.abdessamad.ingsisweb.service;

import com.abdessamad.ingsisweb.model.Utente;
import com.abdessamad.ingsisweb.repository.UtenteRepository;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UtenteService {

    private final UtenteRepository utenteRepository;
    private final BCryptPasswordEncoder passwordEncoder;

    public UtenteService(UtenteRepository utenteRepository, BCryptPasswordEncoder passwordEncoder) {
        this.utenteRepository = utenteRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public void saveUser(Utente utente) {
        utente.setPassword(passwordEncoder.encode(utente.getPassword()));

        // Imposta il ruolo di default come "ROLE_USER" o lascia l'admin con "ROLE_ADMIN"
        if (utente.getRuolo() == null || utente.getRuolo().isEmpty()) {
            utente.setRuolo("ROLE_USER"); // Ruolo di default per i nuovi utenti
        } else if (utente.getRuolo().equalsIgnoreCase("ADMIN")) {
            utente.setRuolo("ROLE_ADMIN"); // Ruolo per gli amministratori
        }

        utenteRepository.save(utente);
    }
}
