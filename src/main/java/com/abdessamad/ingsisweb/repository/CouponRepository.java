package com.abdessamad.ingsisweb.repository;

import com.abdessamad.ingsisweb.model.Coupon;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CouponRepository extends JpaRepository<Coupon, Long> {
    Optional<Coupon> findByCodice(String codice);
}
