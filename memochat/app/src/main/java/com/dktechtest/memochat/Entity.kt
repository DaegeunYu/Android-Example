package com.dktechtest.memochat

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "memo_table")
data class Entity(
    @PrimaryKey(autoGenerate = true)
    val id: Int,
    var favorite: Boolean,
    val text: String,
    val profile: String?
)
