public class PedidoTriggerHandler {
	
    public static void CalculaAtraso(List<Order> orders, Map<Id, Order> ordersMap){

        for(Order ord : orders){

            Order orderMap = ordersMap.get(ord.Id);

            if(ord.DataRealEntrega__c == orderMap.DataRealEntrega__c){
                continue;
            }
            if(ord.DataPrevistaEntrega__c < ord.DataRealEntrega__c){
                ord.DiasAtraso__c = ord.DataPrevistaEntrega__c.daysBetween(ord.DataRealEntrega__c);
                ord.EstaAtrasado__c = true;
            }
        }
    }
    
    public static void CriaHistorico(List<Order> orders, Map<Id, Order> ordersMap){
        
        List<HistoricoAtraso__c> historico = new List<HistoricoAtraso__c>();
        
        for(Order ord : orders){

            Order orderMap = ordersMap.get(ord.Id);

            if(ord.EstaAtrasado__c == orderMap.EstaAtrasado__c){
                continue;
            }
            if(ord.EstaAtrasado__c == true){
                
                HistoricoAtraso__c hist = new HistoricoAtraso__c();
                
                hist.Pedido__c = ord.Id;
                hist.DiasAtraso__c = ord.DiasAtraso__c;
                hist.DataRegistro__c = Date.today();
                
                historico.add(hist);
            }
        }
        if(!historico.isEmpty()){
            insert historico;
        }
    }
}