;; Forgery Detection Contract

;; Constants
(define-constant contract-owner tx-sender)
(define-constant err-not-authorized (err u100))
(define-constant err-not-found (err u101))

;; Data Maps
(define-map authenticity-checks
  { check-id: uint }
  {
    artwork-id: uint,
    verifier: principal,
    result: bool,
    timestamp: uint,
    notes: (string-ascii 500)
  }
)

;; Public Functions
(define-public (record-authenticity-check (check-id uint) (artwork-id uint) (result bool) (notes (string-ascii 500)))
  (let
    (
      (verifier tx-sender)
      (timestamp (get-block-info? time (- block-height u1)))
    )
    (if (is-some timestamp)
      (ok (map-set authenticity-checks
        { check-id: check-id }
        {
          artwork-id: artwork-id,
          verifier: verifier,
          result: result,
          timestamp: (unwrap-panic timestamp),
          notes: notes
        }
      ))
      err-not-authorized
    )
  )
)

(define-read-only (get-authenticity-check (check-id uint))
  (match (map-get? authenticity-checks { check-id: check-id })
    check-data (ok check-data)
    err-not-found
  )
)

;; Private Functions
(define-private (is-contract-owner)
  (is-eq tx-sender contract-owner)
)

