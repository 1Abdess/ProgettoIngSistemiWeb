package com.abdessamad.ingsisweb.service;

import com.abdessamad.ingsisweb.model.Utente;
import com.abdessamad.ingsisweb.repository.UtenteRepository;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    private final UtenteRepository utenteRepository;

    public CustomUserDetailsService(UtenteRepository utenteRepository) {
        this.utenteRepository = utenteRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        Utente utente = utenteRepository.findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("Utente non trovato con email: " + email));

        return User.builder()
                .username(utente.getEmail())
                .password(utente.getPassword())  // Assicurati che la password sia criptata
                .roles(utente.getRuolo().replace("ROLE_", ""))  // Usa il ruolo senza prefisso
                .build();
    }
}
