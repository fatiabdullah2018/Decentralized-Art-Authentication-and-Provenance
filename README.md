# Decentralized Art Authentication and Provenance

## Overview

This blockchain-based platform revolutionizes art authentication, provenance tracking, and ownership management by creating an immutable, transparent record of artworks throughout their lifecycle. By leveraging smart contracts, we provide a trustless system for artists, collectors, galleries, museums, and authenticators to verify artwork origin, track ownership history, monitor exhibition loans, and combat forgeries—ultimately bringing greater trust, transparency, and efficiency to the global art market.

## Smart Contracts

### 1. Artwork Registration Contract

Records comprehensive details of art pieces at the time of creation or initial registration.

**Key Features:**
- Unique digital identity for each artwork
- Detailed artwork metadata (medium, dimensions, date, etc.)
- Artist identity verification and digital signature
- High-resolution image and 3D scan storage
- Material composition documentation
- Creation process evidence recording
- Initial authentication certification
- Artist's statement and artwork description
- Limited edition and series management
- Intellectual property rights documentation

### 2. Ownership Transfer Contract

Manages the secure and transparent transfer of artwork ownership between parties.

**Key Features:**
- Ownership history with complete chain of title
- Transfer authentication and verification
- Conditional ownership transfer rules
- Fractional ownership management
- Sales price recording (optional/private)
- Integration with auction platforms
- Royalty distribution automation
- Gift and inheritance processing
- Escrow functionality for secure transactions
- Tax and regulatory compliance documentation

### 3. Exhibition and Loan Contract

Tracks the movement and display history of artworks across galleries, museums, and exhibitions.

**Key Features:**
- Loan agreement documentation and enforcement
- Exhibition history recording
- Condition reports before and after loans
- Insurance verification and management
- Transportation tracking and verification
- Climate and security condition requirements
- Display positioning and requirements
- Exhibition duration enforcement
- Customs and international shipping documentation
- Visitor and public engagement metrics

### 4. Forgery Detection Contract

Facilitates the process of artwork authentication and provides a framework for challenging and verifying authenticity.

**Key Features:**
- Multi-factor authentication methodology
- Expert authenticator credentialing and reputation
- Material analysis and scientific testing records
- Provenance gap identification
- Authentication consensus mechanisms
- Challenge and dispute resolution
- Forgery alert system and reporting
- Authentication certificate issuance
- Historical authentication record maintenance
- Integration with scientific analysis tools

## System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                       User Interfaces                        │
│  (Artists, Collectors, Galleries, Museums, Authenticators)   │
└───────────────────────────┬─────────────────────────────────┘
                            │
┌───────────────────────────┼─────────────────────────────────┐
│                     Blockchain Layer                         │
├────────────┬───────────────┬────────────────┬───────────────┤
│  Artwork   │   Ownership   │  Exhibition    │    Forgery    │
│Registration│    Transfer   │  and Loan      │   Detection   │
│  Contract  │   Contract    │   Contract     │   Contract    │
└────────────┴───────────────┴────────────────┴───────────────┘
                            │
┌───────────────────────────┼─────────────────────────────────┐
│                    Integration Layer                         │
│   (Gallery Systems, Museum Databases, Authentication Tools)  │
└───────────────────────────┬─────────────────────────────────┘
                            │
┌───────────────────────────┼─────────────────────────────────┐
│                     Storage Layer                            │
│     (IPFS/Arweave, Scientific Data, High-Res Imagery)       │
└─────────────────────────────────────────────────────────────┘
```

## Getting Started

### Prerequisites
- Node.js (v16+)
- Solidity compiler (v0.8+)
- Truffle or Hardhat development environment
- IPFS or Arweave node for decentralized storage
- Ethereum-compatible blockchain (mainnet, testnet, or private)
- Digital scanning and imaging equipment (for artwork registration)

### Installation

1. Clone this repository:
   ```
   git clone https://github.com/yourusername/art-provenance.git
   cd art-provenance
   ```

2. Install dependencies:
   ```
   npm install
   ```

3. Compile smart contracts:
   ```
   npx truffle compile
   ```
   or
   ```
   npx hardhat compile
   ```

4. Deploy to your chosen network:
   ```
   npx truffle migrate --network <network_name>
   ```
   or
   ```
   npx hardhat run scripts/deploy.js --network <network_name>
   ```

5. Configure storage integration:
   ```
   node scripts/configure-ipfs.js
   ```

## Usage Examples

### Artist
```javascript
// Register a new artwork
await artworkContract.registerArtwork(
  {
    title: "Sunset over Venice",
    medium: "Oil on canvas",
    dimensions: {
      height: 76,
      width: 102,
      depth: 3,
      unit: "cm"
    },
    creationDate: "2023-05-15",
    description: "Impressionistic rendering of a Venetian sunset over the Grand Canal",
    edition: {
      isLimited: false,
      number: 1,
      total: 1
    },
    materials: ["oil paint", "linen canvas", "pine stretcher"],
    additionalDetails: {
      signature: "Lower right corner",
      frame: "Custom gold leaf frame"
    },
    imageIPFSHash: "QmXgZV8xVFv8bMSK1YiJ7atMYP2j4dMcPUZC3voVoVfQJb",
    highResolutionScanIPFSHash: "QmA7sK5FzGGXoZbzxqYBv7KXyc94GHSPxTLtMhpJvN8Cz7",
    certificates: ["Certificate of Authenticity"]
  },
  {from: artistAddress}
);
```

### Collector/Gallery
```javascript
// Transfer artwork ownership
await ownershipContract.transferOwnership(
  artworkId,
  newOwnerAddress,
  {
    transferType: "SALE",
    salePrice: ethers.utils.parseEther("15.0"), // 15 ETH
    transferDate: Date.now(),
    paymentVerification: "0x1a2b3c...", // Transaction hash of payment
    includePrivateDetails: false, // Price not publicly visible
    automaticRoyalty: true,
    documents: ["Bill of Sale IPFS Hash"]
  },
  {from: currentOwnerAddress}
);
```

### Museum
```javascript
// Record artwork loan for exhibition
await exhibitionContract.createLoan(
  artworkId,
  {
    loanType: "EXHIBITION",
    borrower: museumAddress,
    lender: ownerAddress,
    startDate: 1654041600, // Unix timestamp
    endDate: 1659312000, // Unix timestamp
    exhibition: {
      title: "Impressionist Masterpieces",
      venue: "Metropolitan Museum of Modern Art",
      location: "New York, USA"
    },
    conditions: {
      environmentalRequirements: {
        tempMin: 18, // Celsius
        tempMax: 22,
        humidityMin: 45, // Percentage
        humidityMax: 55,
        lightMax: 150 // lux
      },
      insurance: {
        provider: "ArtInsure Ltd",
        policyNumber: "POL-123456",
        coverageAmount: "$500,000",
        verificationHash: "QmZ9s..."
      }
    },
    preConditionReport: "QmTz6f...", // IPFS hash of condition report
    transportationDetails: "Fine Art Shipping Co."
  },
  {from: museumAddress}
);
```

### Authenticator
```javascript
// Conduct authentication assessment
await forgeryContract.recordAuthentication(
  artworkId,
  {
    authenticator: {
      name: "Dr. Sarah Johnson",
      credentials: "PhD Art History, 20 years authentication experience",
      institution: "Art Authentication Institute"
    },
    methodsUsed: [
      "VISUAL_INSPECTION",
      "PROVENANCE_REVIEW",
      "MATERIAL_ANALYSIS",
      "SIGNATURE_VERIFICATION",
      "MULTISPECTRAL_IMAGING"
    ],
    scientificTests: [
      {
        testType: "PIGMENT_ANALYSIS",
        result: "Period-appropriate pigments detected",
        labName: "ArtScience Laboratory",
        date: "2023-10-05",
        reportIPFSHash: "QmR7g5..."
      },
      {
        testType: "CANVAS_DATING",
        result: "Canvas fibers consistent with claimed period",
        labName: "Historical Materials Research",
        date: "2023-10-07",
        reportIPFSHash: "QmT6h3..."
      }
    ],
    conclusion: "AUTHENTIC",
    confidenceLevel: 95, // percentage
    notes: "Artwork displays all hallmarks of the artist's middle period",
    certificateIPFSHash: "QmVv8j..."
  },
  {from: authenticatorAddress}
);
```

## Key Features and Benefits

- **Immutable Provenance**: Tamper-proof record of artwork history from creation through all ownership changes
- **Enhanced Due Diligence**: Comprehensive audit trail for collectors and institutions
- **Forgery Deterrence**: Makes creating and selling forgeries substantially more difficult
- **Artist Attribution Protection**: Safeguards artists against misattribution and forgeries
- **Market Transparency**: Increases trust in transactions and valuation
- **Simplified Loans**: Streamlines exhibition loan process with automated agreements
- **Royalty Automation**: Enforces artist resale rights across secondary sales
- **Insurance Integration**: Simplifies claims process with verified ownership and condition documentation
- **Estate Planning**: Simplifies inheritance and donation processes
- **Fractional Ownership**: Enables secure partial ownership of high-value works

## Privacy Considerations

- Selective disclosure of financial transaction details
- Zero-knowledge proofs for sensitive authentication outcomes
- Private ownership options for high-profile collectors
- Granular permission settings for auction and exhibition history
- Compliance with regional art market regulations

## Contributing

We welcome contributions to improve the Decentralized Art Authentication and Provenance platform:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- International Foundation for Art Research (IFAR)
- The Authentication in Art Foundation
- International Council of Museums (ICOM)
- Art Dealers Association of America (ADAA)
- The Artist Rights Society
