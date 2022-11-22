
describe('Product Page', () => {
  beforeEach(() => {
 
    cy.visit('/')
  })

  it("should take you to a product page when you click a product", () => {
    cy.get(".products article").first().click()
    cy.get('article').should('have.class', 'product-detail')
  });
})