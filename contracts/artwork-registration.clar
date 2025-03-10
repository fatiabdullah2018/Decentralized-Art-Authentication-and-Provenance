;; Artwork Registration Contract

;; Constants
(define-constant contract-owner tx-sender)
(define-constant err-not-authorized (err u100))
(define-constant err-already-registered (err u101))
(define-constant err-not-found (err u102))

;; Data Maps
(define-map artworks
  { artwork-id: uint }
  {
    artist: principal,
    title: (string-ascii 100),
    creation-date: uint,
    medium: (string-ascii 50),
    dimensions: (string-ascii 50)
  }
)

;; Public Functions
(define-public (register-artwork (artwork-id uint) (title (string-ascii 100)) (creation-date uint) (medium (string-ascii 50)) (dimensions (string-ascii 50)))
  (let
    (
      (artist tx-sender)
    )
    (if (is-eq tx-sender contract-owner)
      (if (is-none (map-get? artworks { artwork-id: artwork-id }))
        (ok (map-set artworks { artwork-id: artwork-id } { artist: artist, title: title, creation-date: creation-date, medium: medium, dimensions: dimensions }))
        err-already-registered
      )
      err-not-authorized
    )
  )
)

(define-read-only (get-artwork (artwork-id uint))
  (match (map-get? artworks { artwork-id: artwork-id })
    artwork (ok artwork)
    err-not-found
  )
)

;; Private Functions
(define-private (is-contract-owner)
  (is-eq tx-sender contract-owner)
)

