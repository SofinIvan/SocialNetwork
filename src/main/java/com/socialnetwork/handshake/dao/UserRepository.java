package com.socialnetwork.handshake.dao;

import com.socialnetwork.handshake.domain.User;
import org.springframework.data.repository.CrudRepository;

public interface UserRepository extends CrudRepository<User, Long> {

}