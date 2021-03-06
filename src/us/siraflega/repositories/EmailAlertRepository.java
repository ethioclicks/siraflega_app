package us.siraflega.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import us.siraflega.entities.EmailAlertRequest;

public interface EmailAlertRepository extends JpaRepository<EmailAlertRequest, Integer> {
	
	List<EmailAlertRequest> findByRecEmailAddressAndPosition(String recepiantEamil,String position); 
	List<EmailAlertRequest> findByIsVerified(boolean isverified);
	List<EmailAlertRequest> findByRecEmailAddressAndPositionAndVerifyKey(String recepiantEamil,String position,String key);

}
