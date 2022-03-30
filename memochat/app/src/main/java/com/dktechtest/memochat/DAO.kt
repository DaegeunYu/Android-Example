package com.dktechtest.memochat

import androidx.lifecycle.LiveData
import androidx.room.*

@Dao
interface DAO {
    // 데이터 베이스 불러오기
    @Query("SELECT * from memo_table ORDER BY id ASC")
    fun getAll(): LiveData<List<Entity>>

    @Query("SELECT * from memo_table WHERE favorite ORDER BY id ASC")
    fun getFavor(): LiveData<List<Entity>>

    // 데이터 추가
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insert(entity: Entity)

    // 데이터 업데이트
    @Update
    fun update(entity: Entity);

    // 데이터 삭제
    @Delete
    fun delete(entity: Entity);
}