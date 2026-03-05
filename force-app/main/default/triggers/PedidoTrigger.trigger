trigger PedidoTrigger on Order (before insert, before update, after insert, after update) {
	
    if(Trigger.isBefore && Trigger.isUpdate){
        PedidoTriggerHandler.CalculaAtraso(Trigger.new, Trigger.oldMap);
    }
    if(Trigger.isAfter && Trigger.isUpdate){
        PedidoTriggerHandler.CriaHistorico(Trigger.new, Trigger.oldMap);
    }
}