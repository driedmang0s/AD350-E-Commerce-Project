## E-Commerce Marketplace - DB Design Documentation
### Strong entities: User, Product, Transaction - these variables exist independently and each have their own primary keys.
### Weak entities: Inventory, Transaction_Item, Review - these variables depend on other entities for their meaning. Inventory only exists in relation to Product. Transaction_Item depends on both Transaction and Product. Review depends on both User and Product.
### SuperType: User is a supertype where all variables are either subtypes or their own supertype.
