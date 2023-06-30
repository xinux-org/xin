use std::{
    collections::HashMap,
    path::{Path, PathBuf},
};
use thiserror::Error;


/// An error that occurred while attempting to parse a `nix.conf` [`Path`] or
/// [`String`].
#[derive(Debug, Error)]
pub enum ParseError {
    #[error("file '{0}' not found")]
    FileNotFound(PathBuf),
    #[error("file '{0}' included from '{}' not found", .1.as_ref().map(|path| path.display().to_string()).unwrap_or(String::from("<unknown>")))]
    IncludedFileNotFound(PathBuf, Option<PathBuf>),
    #[error("illegal configuration line '{0}' in '{}'", .1.as_ref().map(|path| path.display().to_string()).unwrap_or(String::from("<unknown>")))]
    IllegalConfiguration(String, Option<PathBuf>),
    #[error("failed to read contents of '{0}': {1}")]
    FailedToReadFile(PathBuf, #[source] std::io::Error),
}