
CREATE TABLE IF NOT EXISTS "phones_to_orders"(
  "phoneId" INT REFERENCES "phones"("id") ON DELETE RESTRICT,
  "orderId" INT REFERENCES "orders"("id") ON DELETE CASCADE,
  "quantity" INT NOT NULL CHECK ("quantity" >0 ) DEFAULT 1,
  PRIMARY KEY ("phoneId", "orderId")
); 

--para alterar definiçoes:
ALTER TABLE "phones_to_orders"
DROP CONSTRAINT " FOREIGN KEY "

ALTER TABLE "phones_to_orders"
ADD " FOREIGN KEY "
REFERENCES "orders"("id") ON DELETE CASCADE