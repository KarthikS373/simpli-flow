import FungibleToken from 0xFungibleToken
import NonFungibleToken from 0xNonFungibleToken

pub contract Marketplace {
    // Reference to the FungibleToken contract
    pub let tokenProvider: Capability<&{FungibleToken.FungibleTokenReceiver}>

    // Reference to the NonFungibleToken contract
    pub let nftProvider: Capability<&{NonFungibleToken.CollectionPublic}>

    // Struct representing a listing in the marketplace
    pub struct Listing {
        pub let seller: Address
        pub let price: UFix64
        pub let itemId: UInt64
    }

    // Collection to store listings
    pub var listings: {UInt64: Listing}

    // Event emitted when a new listing is created
    pub event ListingCreated(
        seller: Address,
        price: UFix64,
        itemId: UInt64
    )

    // Function to create a new listing
    pub fun createListing(price: UFix64, itemId: UInt64) {
        let listing = Listing(seller: self.account.address, price: price, itemId: itemId)

        // Store the listing in the collection
        self.listings[itemId] = listing

        // Emit the ListingCreated event
        emit ListingCreated(seller: self.account.address, price: price, itemId: itemId)
    }

    // Function to buy a listed item
    pub fun buyItem(itemId: UInt64) {
        // Get the listing for the given itemId
        let listing = self.listings[itemId]

        // Transfer the listed price from the buyer to the seller
        FungibleToken.withdraw(from: <-tokenProvider.borrow()!, amount: listing.price)
        FungibleToken.deposit(to: listing.seller, amount: listing.price)

        // Transfer ownership of the NFT item to the buyer
        let collectionRef = self.nftProvider.borrow<&{NonFungibleToken.CollectionPublic}>()
            ?? panic("Could not borrow a reference to the NFT collection")
        collectionRef.borrowNFT(id: listing.itemId).transfer(to: self.account)

        // Remove the listing from the collection
        self.listings.remove(key: itemId)
    }
}
