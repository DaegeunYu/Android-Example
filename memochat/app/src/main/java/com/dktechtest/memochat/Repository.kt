package com.dktechtest.memochat

import androidx.lifecycle.LiveData

class Repository(mDatabase: MemoDatebase) {
    private val dao = mDatabase.dao()
    val allMemos: LiveData<List<Entity>> = dao.getAll()
    val favoriteMemos: LiveData<List<Entity>> = dao.getFavor()

    fun insert(entity: Entity) {
        dao.insert(entity)
    }

    fun delete(entity: Entity) {
        dao.delete(entity)
    }

    fun update(entity: Entity) {
        dao.update(entity)
    }
}