;; Ownership Transfer Contract

;; Constants
(define-constant contract-owner tx-sender)
(define-constant err-not-authorized (err u100))
(define-constant err-not-found (err u101))
(define-constant err-not-owner (err u102))

;; Data Maps
(define-map artwork-ownership
  { artwork-id: uint }
  { owner: principal }
)

;; Public Functions
(define-public (transfer-ownership (artwork-id uint) (new-owner principal))
  (let
    (
      (current-owner (get current-owner artwork-id))
    )
    (if (is-eq (ok tx-sender) current-owner)
      (ok (map-set artwork-ownership { artwork-id: artwork-id } { owner: new-owner }))
      err-not-owner
    )
  )
)

(define-read-only (get-owner (artwork-id uint))
  (match (map-get? artwork-ownership { artwork-id: artwork-id })
    ownership (ok (get owner ownership))
    err-not-found
  )
)

;; Private Functions
(define-private (get current-owner (artwork-id uint))
  (match (map-get? artwork-ownership { artwork-id: artwork-id })
    ownership (ok (get owner ownership))
    (ok contract-owner)
  )
)

