package com.abdessamad.ingsisweb.repository;

import com.abdessamad.ingsisweb.model.CouponOrdine;
import com.abdessamad.ingsisweb.model.Carrello;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface CouponOrdineRepository extends JpaRepository<CouponOrdine, Integer> {
    Optional<CouponOrdine> findByCarrelloAndCouponId(Carrello carrello, int couponId);
}
