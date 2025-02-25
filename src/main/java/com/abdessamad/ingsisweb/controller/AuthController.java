package com.abdessamad.ingsisweb.controller;

import com.abdessamad.ingsisweb.model.Utente;
import com.abdessamad.ingsisweb.repository.UtenteRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.time.LocalDateTime;

@Controller
public class AuthController {
    @Autowired
    private UtenteRepository utenteRepository;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    // ========================== Registrazione ==========================
    // Mostra il form di registrazione
    @GetMapping("/registrazione")
    public String showRegistrationForm(Model model) {
        model.addAttribute("utente", new Utente());
        return "registrazione";  // Pagina JSP per la registrazione
    }

    // Gestisce la registrazione di un nuovo utente
    @PostMapping("/registrazione")
    public String registerUser(Utente utente, Model model) {
        // Cripta la password inserita dall'utente
        utente.setPassword(passwordEncoder.encode(utente.getPassword()));

        // Imposta il ruolo di default come "USER"
        utente.setRuolo("USER");

        // Imposta la data di creazione se non è già impostata
        if (utente.getDataCreazione() == null) {
            utente.setDataCreazione(LocalDateTime.now());
        }

        // Salva il nuovo utente nel database
        utenteRepository.save(utente);

        // Reindirizza alla pagina di login
        return "redirect:/login";
    }

    // ========================== Login ==========================
    // Mostra la pagina di login
    @GetMapping("/login")
    public String showLoginForm() {
        return "login";  // Pagina JSP per il login
    }

    // Gestisce il successo del login
    @GetMapping("/loginSuccess")
    public String loginSuccess(Authentication authentication, HttpSession session) {
        // Recupera l'utente autenticato
        Utente utente = (Utente) authentication.getPrincipal();

        // Salva l'utente nella sessione
        session.setAttribute("utente", utente);

        // Reindirizza alla homepage
        return "redirect:/";
    }
}
