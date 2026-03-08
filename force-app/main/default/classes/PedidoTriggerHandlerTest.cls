@isTest
public class PedidoTriggerHandlerTest {
    
    @isTest
  	static void criaBaseDados(){
        
        Account acc = new Account(Name = 'Acc Teste');
        insert acc;
        
		Product2 prod = new Product2(
        	Name = 'Teste',
			IsActive = true
        );
        insert prod;
        
        Id stdPricebookId = Test.getStandardPricebookId();

        PricebookEntry price = new PricebookEntry(
            Pricebook2Id = stdPricebookId,
            Product2Id = prod.Id,
            UnitPrice = 100,
            IsActive = true
        );
        insert price;
        
        Order order = new Order(
            AccountId = acc.Id,
            Status = 'Draft',
            Pricebook2Id = stdPricebookId,
            EffectiveDate = Date.today().addDays(-25)
        );
        insert order;
        
        OrderItem item = new OrderItem(
            OrderId = order.Id,
            PricebookEntryId = price.Id,
            Quantity = 1,
            UnitPrice = 100
    	);
    	insert item;
        
        order.Status = 'Activated';
        update order;
        
        HistoricoAtraso__c historico = new HistoricoAtraso__c(
        	Pedido__c = order.Id,
            DiasAtraso__c = 5,
            DataRegistro__c = Date.today()
        );
        insert historico;
        
        Test.startTest();
        
        order.DataPrevistaEntrega__c = Date.today().addDays(-15);
        order.DataRealEntrega__c = Date.today();
        update order;
        
        order.EstaAtrasado__c = true;
        update order;
        
        Test.stopTest();
    }
}