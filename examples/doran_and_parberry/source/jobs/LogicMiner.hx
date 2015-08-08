package jobs;
import bazaarbot.Agent;
import bazaarbot.BazaarBot;

/**
 * ...
 * @author larsiusprime
 */
class LogicMiner extends LogicGeneric
{

	public function new(?data:Dynamic)
	{
		super(data);
	}
	
	override public function perform(agent:Agent, bazaar:BazaarBot):Void 
	{
		var food = agent.queryInventory("food");
		var tools = agent.queryInventory("tools");
		
		var has_food = food >= 1;
		var has_tools = tools >= 1;
		
		if (has_food)
		{
			if (has_tools)
			{
				//produce 4 ore, consume 1 food, break tools with 10% chance
				_produce(agent,"ore",4);
				_consume(agent,"food",1);
				_consume(agent,"tools",1,0.1);
			}
			else
			{
				//produce 2 ore, consume 1 food
				_produce(agent,"ore",2);
				_consume(agent,"food",1);
			}
		}
		else
		{
			//fined $2 for being idle
			_consume(agent,"money",2);
			if (!has_food && agent.inventoryFull)
			{
				makeRoomFor(bazaar, agent,"food",2);
			}
		}
	}
}