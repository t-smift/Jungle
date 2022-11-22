describe('Adding to cart', () => {
  beforeEach(() => {
 
    cy.visit('/')
  })
  it("cart should be 0 after adding should be 1", () => {
    cy.contains("My Cart (0)");
    cy.get("[alt=Add]").first().click({ force: true });
    cy.contains("My Cart (1)");
  });
});