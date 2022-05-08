
public class DecissionTree {
	public String findSeller(Vehicle v) {

		if(v.getOwner().contentEquals("First Owner") || 
				v.getOwner().contentEquals("Test Drive Car")) {
			if(v.getTransmission().contentEquals("Automatic")) {
				if(v.getKm().contentEquals("50000 < x <= 65000") || 
						v.getKm().contentEquals("80000 < x <= 95000")) {
					return("Dealer (1%)");
				}else{
					if(v.getPrice().contentEquals("200000 < x <= 300000") || 
							v.getPrice().contentEquals("500000 < x <= 600000")) {
						return("Dealer (1%)");
					}else{
						return("Individual (5%)");
					}
				}
			}else{
				if(v.getPrice().contentEquals("300000 < x <= 400000") || 
						v.getPrice().contentEquals("400000 < x <= 500000") || 
						v.getPrice().contentEquals("x > 600000")){
					if(v.getKm().contentEquals("50000 < x <= 65000")) {
						if(v.getYear().contentEquals("2010 < x <= 2015")) {
							return("Dealer (3%)");
						}else{
							return("Individual (2%)");
						}
					}else{
						return("Individual (31%)");
					}
				}else{
					return("Individual (21%)");
				}
			}
		}else{
			return("Individual (34%)");
		}
	}

	public String findOwner(Vehicle v) {

		if(v.getYear().contentEquals("year = 2015 < x <= 2020")) {
			return("First owner (33%)");
		}else{
			if(v.getSeller().contentEquals("Dealer") || 
					v.getSeller().contentEquals("Trustmark Dealer")) {
				return("First owner (15%)");
			}else{
				if(v.getKm().contentEquals("35000 < x <= 50000") || 
						v.getKm().contentEquals("x <= 35000")){
					return("First owner (12%)");
				}else{
					if(v.getYear().contentEquals("2010 < x <= 2015")) {
						return("First owner (22%)");
					}else{
						return("Second owner (18%)");
					}
				}
			}
		} 
	}	
}
