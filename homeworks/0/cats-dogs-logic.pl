/*
 * Logical puzzle.
 *
 * Butsie is a brown cat, ""Cornie"" is a black cat, "Mac" is a red cat.
 * "Flash", "Rover" and "Spot" are dogs. "Flash" is a "Spot"ted dog, "Rover"
 * is a red dog and "Spot" is a white dog. "Fluffy" is a black dog.
 *
 * Tom owns any pet that is either brown or black. Kate owns all
 * non-white dogs, not belonging to Tom.
 *
 * All pets Kate or Tom owns are pedigree animals.
 *
 * Alan owns "Mac" if Kate does not own Butsie and "Spot" is not a pedigree
 * animal.
 *
 * Write a Prolog program that answers, which animals do not have an owner.
*/

% Animal types
animalType("Bustie", cat).
animalType("Cornie", cat).
animalType("Mac", cat).

animalType("Flash", dog).
animalType("Rover", dog).
animalType("Spot", dog).
animalType("Fluffy", dog).

% colours 
colour("Bustie", brown).
colour("Cornie", black).
colour("Mac", red).

colour("Flash", spotted).
colour("Rover", red).
colour("Spot", white).
colour("Fluffy", black).

% Tom's pets
tomsPet(X) :- colour(X, brown); colour(X, black).

% Kate's pets
katesPet(X) :- animalType(X, dog), not(colour(X, white)), not(tomsPet(X)).

% Pedigree animals
pedigree(X) :- tomsPet(X); katesPet(X).

% Alan's pets
alansPet("Mac") :- (not(katesPet("Bustie")), not(pedigree("Spot"))).

% Animals that has no owner
hasNoOwner(X) :- not(tomsPet(X); katesPet(X); alansPet(X)).