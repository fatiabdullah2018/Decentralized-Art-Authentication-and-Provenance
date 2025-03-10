;; Exhibition and Loan Contract

;; Constants
(define-constant contract-owner tx-sender)
(define-constant err-not-authorized (err u100))
(define-constant err-not-found (err u101))
(define-constant err-already-on-loan (err u102))

;; Data Maps
(define-map loans
  { artwork-id: uint }
  {
    borrower: principal,
    start-date: uint,
    end-date: uint,
    location: (string-ascii 100)
  }
)

;; Public Functions
(define-public (create-loan (artwork-id uint) (borrower principal) (start-date uint) (end-date uint) (location (string-ascii 100)))
  (if (is-eq tx-sender contract-owner)
    (match (map-get? loans { artwork-id: artwork-id })
      loan-data err-already-on-loan
      (ok (map-set loans { artwork-id: artwork-id } { borrower: borrower, start-date: start-date, end-date: end-date, location: location }))
    )
    err-not-authorized
  )
)

(define-public (end-loan (artwork-id uint))
  (if (is-eq tx-sender contract-owner)
    (ok (map-delete loans { artwork-id: artwork-id }))
    err-not-authorized
  )
)

(define-read-only (get-loan-info (artwork-id uint))
  (match (map-get? loans { artwork-id: artwork-id })
    loan-data (ok loan-data)
    err-not-found
  )
)

;; Private Functions
(define-private (is-contract-owner)
  (is-eq tx-sender contract-owner)
)

