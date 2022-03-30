package com.dktechtest.memochat

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import kotlinx.coroutines.CoroutineScope

@Database(entities = [Entity::class], version = 1, exportSchema = false)
abstract class MemoDatebase : RoomDatabase() {
    abstract fun dao(): DAO

    companion object {
        private var INSTANCE: MemoDatebase? = null

        fun getDatabase(context: Context, scope: CoroutineScope) : MemoDatebase {
            return INSTANCE ?: synchronized(this) {
                val instance = Room.databaseBuilder(
                    context.applicationContext,
                    MemoDatebase::class.java,
                    "database"
                )   .fallbackToDestructiveMigration()
                    .build()
                INSTANCE = instance

                instance
            }
        }
    }
}